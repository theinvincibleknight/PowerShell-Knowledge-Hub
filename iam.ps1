# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all IAM users
$iamUsers = Get-IAMUser

# Create an array to store IAM user details
$iamUserDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Generate timestamp for Excel file name
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\IAM_User_Details.xlsx"

# Iterate through each IAM user
foreach ($iamUser in $iamUsers) {
    # Fetch additional IAM user details
    $iamUserDetail = Get-IAMUser -UserName $iamUser.UserName

    # IAM User Details
    $iamUserDetail = [PSCustomObject]@{
        SrNo                = $srNo++
        Username            = $iamUser.UserName
        Groups              = ($iamUser.Groups | ForEach-Object { $_.GroupName }) -join ', '
        MFA                 = ($iamUserDetail.MFADevices | ForEach-Object { $_.SerialNumber }) -join ', '
        ConsoleAccess       = $null -ne $iamUserDetail.PasswordLastUsed
        AccessKeyID         = $iamUserDetail.AccessKeys.AccessKeyId
        AccessKeyState      = $iamUserDetail.AccessKeys.Status
    }

    $iamUserDetails += $iamUserDetail
}

# Export IAM User Details to Excel
$iamUserDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'IAMUsers'

Write-Host "IAM user details exported to $excelFilePath"