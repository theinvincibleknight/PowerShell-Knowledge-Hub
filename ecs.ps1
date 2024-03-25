# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all ECS clusters
$ecsClusters = Get-ECSClusters

# Create an array to store ECS details
$ecsDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each ECS cluster
foreach ($ecsCluster in $ecsClusters) {
    # Try to retrieve details for each cluster
    try {
        # Fetch ECS services for the cluster
        $ecsServices = Get-ECSClusterService -Cluster $ecsCluster.ClusterName

        # ECS Details
        $ecsDetail = [PSCustomObject]@{
            SrNo             = $srNo++
            Clusters         = $ecsCluster.ClusterName
            Services         = $ecsServices.ServiceName -join ', '
            TasksRunning     = $ecsServices.RunningTasksCount
        }
        $ecsDetails += $ecsDetail
    }
    catch {
        Write-Host "Failed to retrieve details for cluster $($ecsCluster.ClusterName) : $_"
    }
}

# Generate timestamp for Excel file name
$currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\ECS_Details_$currentDateTime.xlsx"

# Export ECS Details to Excel
$ecsDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'ECSClusters'

Write-Host "ECS details exported to $excelFilePath"