# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch EC2 instances
$instances = Get-EC2Instance

# Create an array to store instance details
$instanceDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each EC2 instance
foreach ($instance in $instances.Instances) {
    $elasticIp = $instance.PublicIpAddress
    if ($instance.NetworkInterfaces.Association.PublicIp) {
        $elasticIp = $instance.NetworkInterfaces.Association.PublicIp
    }

    $instanceDetail = [PSCustomObject]@{
        SrNo              = $srNo++
        Name              = ($instance.Tags | Where-Object { $_.Key -eq 'Name' }).Value
        InstanceId        = $instance.InstanceId
        PublicIp          = $instance.PublicIpAddress
        ElasticIp         = $elasticIp
        PrivateIp         = $instance.PrivateIpAddress
        InstanceState     = $instance.State.Name
        InstanceType      = $instance.InstanceType
        OSVersion         = $instance.Platform
        VolumeId          = $instance.BlockDeviceMappings.Ebs.VolumeId
        VolumeSize        = $instance.BlockDeviceMappings.Ebs.VolumeSize
        AvailabilityZone  = $instance.Placement.AvailabilityZone
        SecurityGroupName = $instance.SecurityGroups.GroupName -join ','
        SecurityGroupId   = $instance.SecurityGroups.GroupId -join ','
        VPC               = $instance.VpcId
        Subnet            = $instance.SubnetId
    }
    $instanceDetails += $instanceDetail
}

# Export to Excel
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\EC2_Instances.xlsx"
$instanceDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow

Write-Host "AWS EC2 instance details exported to $excelFilePath"