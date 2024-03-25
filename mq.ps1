# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all MQ brokers
$mqBrokers = Get-MQBroker

# Create an array to store MQ details
$mqDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each MQ broker
foreach ($mqBroker in $mqBrokers) {
    # MQ Details
    $mqDetail = [PSCustomObject]@{
        SrNo                = $srNo++
        Type                = $mqBroker.EngineType
        BrokerName          = $mqBroker.BrokerName
        Region              = $mqBroker.BrokerRegion
        BrokerInstanceType  = $mqBroker.HostInstanceType
        BrokerEngine        = $mqBroker.EngineType
        BrokerEngineVersion = $mqBroker.EngineVersion
        Endpoint            = $mqBroker.BrokerInstances[0].Endpoints
    }
    $mqDetails += $mqDetail
}

# Generate timestamp for Excel file name
# $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
# $excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\MQ_Details_$currentDateTime.xlsx"

$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\MQ_Details.xlsx"

# Export MQ Details to Excel
$mqDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'MQBrokers'

Write-Host "MQ details exported to $excelFilePath"