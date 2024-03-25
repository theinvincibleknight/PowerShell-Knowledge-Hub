# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all S3 buckets
$s3Buckets = Get-S3Bucket

# Create an array to store S3 bucket details
$s3BucketDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each S3 bucket
foreach ($s3Bucket in $s3Buckets) {
    # S3 Bucket Details
    $s3BucketDetail = [PSCustomObject]@{
        SrNo          = $srNo++
        Name          = $s3Bucket.BucketName
        Region        = $s3Bucket.LocationConstraint
        #Region        = s3.get_bucket_location(Bucket=BucketName).get('LocationConstraint', 'us-east-1') or 'us-east-1'
        Access        = $s3Bucket.Grants.Permission -join ', '
        CreationDate  = $s3Bucket.CreationDate
    }
    $s3BucketDetails += $s3BucketDetail
}

# Generate timestamp for Excel file name
# $currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\S3_Bucket_Details.xlsx"

# Export S3 Bucket Details to Excel
$s3BucketDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'S3Buckets'

Write-Host "S3 Bucket details exported to $excelFilePath"