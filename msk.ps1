# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all MSK clusters
$mskClusters = Get-MSKCluster

# Create an array to store MSK details
$mskDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each MSK cluster
foreach ($mskCluster in $mskClusters) {
    # MSK Details
    $mskDetail = [PSCustomObject]@{
        SrNo                  = $srNo++
        ClusterName           = $mskCluster.ClusterName
        ClusterType           = $mskCluster.ClusterType
        ApacheKafkaVersion    = $mskCluster.KafkaVersion
        BrokerType            = $mskCluster.BrokerNodeGroupInfo.BrokerNodeType
        EBSStoragePerBroker   = $mskCluster.BrokerNodeGroupInfo.StorageInfo.EbsStorageInfo.VolumeSize
        BrokersPerZone        = $mskCluster.NumberOfBrokerNodes
        Zone                  = $mskCluster.AvailabilityZones -join ','
        Region                = $mskCluster.Region
        SecurityGroups        = $mskCluster.EncryptionInfo.EncryptionAtRest.KmsKeyId
        VPC                   = $mskCluster.VpcId
        Subnet                = $mskCluster.SubnetIds -join ','
        BrokerDetails         = $mskCluster.BrokerNodeGroupInfo.BrokerAZDistribution
    }
    $mskDetails += $mskDetail
}

# Generate timestamp for Excel file name
## $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\MSK_Details.xlsx"

# Export MSK Details to Excel
$mskDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'MSKClusters'

Write-Host "MSK details exported to $excelFilePath"