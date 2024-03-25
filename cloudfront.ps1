# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all CloudFront distributions
$cloudFrontDistributions = Get-CFDistributionList

# Create an array to store CloudFront details
$cloudFrontDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Generate timestamp for Excel file name
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\CloudFront_Details.xlsx"

# Iterate through each CloudFront distribution
foreach ($cloudFrontDistribution in $cloudFrontDistributions) {
    # CloudFront Details
    $cloudFrontDetail = [PSCustomObject]@{
        SrNo                        = $srNo++
        ID                          = $cloudFrontDistribution.Id
        Type                        = if ($cloudFrontDistribution.Origins.Items[0].S3OriginConfig.OriginAccessIdentity) { 'S3' } else { 'Custom' }
        DomainName                  = $cloudFrontDistribution.DomainName
        AlternativeDomainNames      = $cloudFrontDistribution.Aliases.Items -join ', '
        Origins                     = $cloudFrontDistribution.Origins.Items[0].DomainName
        Status                      = $cloudFrontDistribution.Status
    }

    $cloudFrontDetails += $cloudFrontDetail
}

# Export CloudFront Details to Excel
$cloudFrontDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'CloudFrontDistributions'

Write-Host "CloudFront details exported to $excelFilePath"