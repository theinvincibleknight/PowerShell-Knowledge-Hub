# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all security groups
$securityGroups = Get-EC2SecurityGroup

# Create an array to store security group details
$securityGroupDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Generate timestamp for Excel file name
# $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\SecurityGroup_Details.xlsx"

# Iterate through each security group
foreach ($securityGroup in $securityGroups) {
    foreach ($permission in $securityGroup.IpPermissions) {
        # Security Group Details
        $securityGroupDetail = [PSCustomObject]@{
            SrNo                  = $srNo++
            SecurityGroupId       = $securityGroup.GroupId
            SecurityGroupName     = $securityGroup.GroupName
            TrafficType           = 'Ingress'
            Protocol              = $permission.IpProtocol
            FromPort              = $permission.FromPort
            ToPort                = $permission.ToPort
            SourceDestinationIP   = $permission.IpRanges.CidrIp -join ', '
            Description           = $securityGroup.Description
        }
        $securityGroupDetails += $securityGroupDetail
    }

    foreach ($permission in $securityGroup.IpPermissionsEgress) {
        # Security Group Details for Egress
        $securityGroupDetail = [PSCustomObject]@{
            SrNo                  = $srNo++
            SecurityGroupId       = $securityGroup.GroupId
            SecurityGroupName     = $securityGroup.GroupName
            TrafficType           = 'Egress'
            Protocol              = $permission.IpProtocol
            FromPort              = $permission.FromPort
            ToPort                = $permission.ToPort
            SourceDestinationIP   = $permission.IpRanges.CidrIp -join ', '
            Description           = $securityGroup.Description
        }
        $securityGroupDetails += $securityGroupDetail
    }
}

# Export Security Group Details to Excel
$securityGroupDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'SecurityGroups'

Write-Host "Security Group details exported to $excelFilePath"