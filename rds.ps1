# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all RDS instances
$rdsInstances = Get-RDSDBInstance

# Create an array to store RDS details
$rdsDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Generate timestamp for Excel file name
# $excelFilePath = "C:\Users\YourUserName\Downloads\RDS_Details_$(Get-Date -Format 'yyyyMMdd_HHmmss').xlsx"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\RDS_Details.xlsx"

# Iterate through each RDS instance
foreach ($rdsInstance in $rdsInstances) {
    # RDS Details
    $rdsDetail = [PSCustomObject]@{
        SrNo                  = $srNo++
        DBIdentifier          = $rdsInstance.DBInstanceIdentifier
        Endpoint              = $rdsInstance.Endpoint.Address
        Port                  = $rdsInstance.Endpoint.Port
        Role                  = $rdsInstance.DBInstanceRole
        Engine                = $rdsInstance.Engine
        AvailabilityZone      = $rdsInstance.AvailabilityZone
        Size                  = $rdsInstance.DBInstanceClass
        VPC                   = $rdsInstance.DBSubnetGroup.VpcId
        MultiAZ               = $rdsInstance.MultiAZ
        AutoBackup            = $rdsInstance.AutoMinorVersionUpgrade
        SecurityGroup         = $rdsInstance.VpcSecurityGroups.GroupName -join ', '
    }
    $rdsDetails += $rdsDetail
}

# Export RDS Details to Excel
$rdsDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'RDSInstances'

Write-Host "RDS details exported to $excelFilePath"