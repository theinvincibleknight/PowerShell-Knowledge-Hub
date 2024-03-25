# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Fetch all EBS volumes
$ebsVolumes = Get-EC2Volume

# Create an array to store EBS volume details
$ebsVolumeDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Generate timestamp for Excel file name
#$currentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$excelFilePath = "C:\Users\Akshay Hegde\Downloads\Files\EBS_Volume_Details.xlsx"

# Iterate through each EBS volume
foreach ($ebsVolume in $ebsVolumes) {
    # Get attached instances
    $attachedInstances = $ebsVolume.Attachments | ForEach-Object { $_.InstanceId }

    # EBS Volume Details
    $ebsVolumeDetail = [PSCustomObject]@{
        SrNo                  = $srNo++
        VolumeName            = $ebsVolume.Tags | Where-Object { $_.Key -eq 'Name' } | Select-Object -ExpandProperty Value
        VolumeId              = $ebsVolume.VolumeId
        Type                  = $ebsVolume.VolumeType
        Size                  = $ebsVolume.Size
        Encryption            = $ebsVolume.Encrypted
        AttachedInstances     = $attachedInstances -join ', '
        AvailabilityZone      = $ebsVolume.AvailabilityZone
    }
    $ebsVolumeDetails += $ebsVolumeDetail
}

# Export EBS Volume Details to Excel
$ebsVolumeDetails | Export-Excel -Path $excelFilePath -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'EBSVolumes'

Write-Host "EBS Volume details exported to $excelFilePath"