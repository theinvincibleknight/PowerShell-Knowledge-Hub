# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all ACM certificates
$certificates = Get-ACMCertificate

# Create an array to store certificate details
$certificateDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each certificate
foreach ($certificate in $certificates) {
    # Certificate Details
    $certificateDetail = [PSCustomObject]@{
        SrNo                = $srNo++
        CertificateId       = $certificate.CertificateArn.Split('/')[-1]
        DomainName          = $certificate.DomainName
        Type                = $certificate.Type
        Status              = $certificate.Status
        InUse               = $certificate.InUseBy.Count -gt 0
        RenewalEligibility  = $certificate.RenewalEligibility
        KeyAlgorithm        = $certificate.KeyAlgorithm
        Resources           = $certificate.InUseBy -join ', '
        Region              = $certificate.Region
    }
    $certificateDetails += $certificateDetail
}

# Generate timestamp for Excel file name
# $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
# $excelFilePath = "C:\Users\YourUserName\Downloads\Certificate_Details_$currentDateTime.xlsx"

$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\Certificate_Details.xlsx"

# Export Certificate Details to Excel
$certificateDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'Certificates'

Write-Host "Certificate details exported to $excelFilePath"