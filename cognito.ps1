# Install AWS.Tools.CognitoIdentity if not already installed
# Install-Module -Name AWS.Tools.CognitoIdentity -Force -AllowClobber

# Import the AWS.Tools.CognitoIdentity module
# Import-Module AWS.Tools.CognitoIdentity

# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all Cognito user pools
$cognitoUserPools = Get-CGIPUserPool

# Create an array to store Cognito details
$cognitoDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each Cognito user pool
foreach ($userPool in $cognitoUserPools) {
    # Fetch the number of users in the user pool
    $numberOfUsers = (Get-CGIPUser -UserPoolId $userPool.Id).Count

    # Cognito Details
    $cognitoDetail = [PSCustomObject]@{
        SrNo            = $srNo++
        UserPoolName    = $userPool.Name
        UserPoolId      = $userPool.Id
        NumberOfUsers   = $numberOfUsers
        Region          = $userPool.Region
    }
    $cognitoDetails += $cognitoDetail
}

# Generate timestamp for Excel file name
# $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
# $excelFilePath = "C:\Users\YourUserName\Downloads\Cognito_Details_$currentDateTime.xlsx"

$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\CognitoDetails.xlsx"

# Export Cognito Details to Excel
$cognitoDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'CognitoUserPools'

Write-Host "Cognito details exported to $excelFilePath"