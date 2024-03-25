# Install AWSPowerShell.NetCore if not already installed
# Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber

# Import the AWSPowerShell.NetCore module
Import-Module AWSPowerShell.NetCore

# Run AWS CLI command to list EFS file systems
$efsInfo = aws efs describe-file-systems --output json | ConvertFrom-Json

# Create an array to store EFS details
$efsDetails = @()

# Initialize Sr. No. counter
$srNo = 1

# Iterate through each EFS file system
foreach ($efsFileSystem in $efsInfo.FileSystems) {
    # Get VPC and SubnetId from EFS Mount Targets
    $mountTargets = aws efs describe-mount-targets --file-system-id $efsFileSystem.FileSystemId --output json | ConvertFrom-Json
    $vpc = $mountTargets.MountTargets[0].VpcId
    $subnetId = $mountTargets.MountTargets[0].SubnetId
    $ipaddress = $mountTargets.MountTargets[0].IpAddress

    # Get Security Groups using AWS CLI command
    $securityGroupsCommand = "aws efs describe-mount-target-security-groups --mount-target-id $($mountTargets.MountTargets[0].MountTargetId) --output json"
    $securityGroups = Invoke-Expression -Command $securityGroupsCommand | ConvertFrom-Json

    # Check if the returned data is not null and contains MountTargets
    if ($securityGroups -and $securityGroups.MountTargets) {
        # Access Security Groups
        $securityGroups = $securityGroups.MountTargets[0].SecurityGroups -join ', '
    } else {
        # If data is null or empty, set to empty string
        $securityGroups = ''
    }

    # EFS Details
    $efsDetail = [PSCustomObject]@{
        SrNo                 = $srNo++
        Name                 = $efsFileSystem.Name
        FileSystemId         = $efsFileSystem.FileSystemId
        TotalSize            = $efsFileSystem.SizeInBytes
        AvailabilityZone     = $efsFileSystem.AvailabilityZoneName
        VPC                  = $vpc
        SubnetId             = $subnetId
        IpAddress            = $ipaddress
        SecurityGroups       = $securityGroups
    }
    $efsDetails += $efsDetail
}

# Export EFS Details to Excel
$efsDetails | Export-Excel -Path "C:\Users\Akshay Hegde\Downloads\Files\EFS_Details.xlsx" -AutoSize -FreezeTopRow -BoldTopRow -WorksheetName 'EFSFileSystems'

Write-Host "EFS details exported to Excel."