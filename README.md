# PowerShell-Knowledge-Hub
This repository primarily focuses on PowerShell scripts for managing and automating AWS-related tasks. It may also include some system administration and operational scripts.

## Installing the AWS Tools for PowerShell on Windows
A Windows-based computer can run any of the AWS Tools for PowerShell package options:
- AWS.Tools - The modularized version of AWS Tools for PowerShell. Each AWS service is supported by its own individual, small module, with shared support modules AWS.Tools.Common and AWS.Tools.Installer.
- AWSPowerShell.NetCore - The single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.

Setting up the AWS Tools for PowerShell involves the following high-level tasks, described in detail in this topic.
1. Install the AWS Tools for PowerShell package option that's appropriate for your environment.
2. Verify that script execution is enabled by running the Get-ExecutionPolicy cmdlet.
3. Import the AWS Tools for PowerShell module into your PowerShell session.

## Install AWS.Tools on Windows
You can install the modularized version of AWS Tools for PowerShell on computers that are running Windows with Windows PowerShell 5.1, or PowerShell Core 6.0 or later. 

You can install `AWS.Tools` in one of three ways:

- Using the cmdlets in the `AWS.Tools` package. The `AWS.Tools.Installer` module simplifies the installation and update of other `AWS.Tools` modules. The `AWS.Tools.Installer` requires, automatically downloads, and installs an updated version of `PowerShellGet`. The `AWS.Tools.Installer` module automatically keeps your module versions in sync; when you install or update to a newer version of one module, the cmdlets in the `AWS.Tools.Installer` automatically update all of your other `AWS.Tools` modules to the same version.
- Downloading the modules from [AWS.Tools.zip](https://sdk-for-net.amazonwebservices.com/ps/v4/latest/AWS.Tools.zip) and extracting them in one of the module folders. You can discover your module folders by displaying the value of the PSModulePath environment variable.
- Installing each service module from the PowerShell Gallery using the `Install-Module` and `Install-AWSToolsModule` cmdlets. This method is described in the following procedure.

### To install AWS.Tools on Windows using the Install-Module cmdlet
1. Start a PowerShell session.

> Note:
We recommend that you don't run PowerShell as an administrator with elevated permissions except when required by the task at hand. This is because of the potential security risk and is inconsistent with the principle of least privilege.

2. To install the modularized `AWS.Tools` package, run the following command.

```PowerShell
PS > Install-Module -Name AWS.Tools.Installer

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure
 you want to install the modules from 'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y
```
If you are notified that the repository is "untrusted", it asks you if you want to install anyway. Enter `y` to allow PowerShell to install the module. To avoid the prompt and install the module without trusting the repository, you can run the command with the `-Force` parameter.

```PowerShell
PS > Install-Module -Name AWS.Tools.Installer -Force
```
You can now install the module for each AWS service that you want to use by using the `Install-AWSToolsModule` cmdlet. For example, the following command installs the Amazon EC2 and Amazon S3 modules. This command also installs any dependent modules that are required for the specified module to work. For example, when you install your first `AWS.Tools` service module, it also installs `AWS.Tools.Common`. This is a shared module required by all AWS service modules. It also removes older versions of the modules, and updates other modules to the same newer version.

```PowerShell
PS > Install-AWSToolsModule AWS.Tools.EC2,AWS.Tools.S3 -CleanUp
  Confirm
  Are you sure you want to perform this action?
  Performing the operation "Install-AWSToolsModule" on target "AWS Tools version 4.0.0.0".
  [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):

  Installing module AWS.Tools.Common version 4.0.0.0
  Installing module AWS.Tools.EC2 version 4.0.0.0
  Installing module AWS.Tools.Glacier version 4.0.0.0
  Installing module AWS.Tools.S3 version 4.0.0.0

  Uninstalling AWS.Tools version 3.3.618.0
  Uninstalling module AWS.Tools.Glacier
  Uninstalling module AWS.Tools.S3
  Uninstalling module AWS.Tools.SimpleNotificationService
  Uninstalling module AWS.Tools.SQS
  Uninstalling module AWS.Tools.Common
```
> Note:
The `Install-AWSToolsModule` cmdlet downloads all requested modules from the `PSRepository` named `PSGallery` (https://www.powershellgallery.com/) and considers it a trusted source. Use the command `Get-PSRepository -Name PSGallery` for more information about this `PSRepository`.

By default, the previous command installs modules into the `%USERPROFILE%\Documents\WindowsPowerShell\Modules `folder. To install the AWS Tools for PowerShell for all users of a computer, you must run the following command in a PowerShell session that you started as an administrator. For example, the following command installs the IAM module to the `%ProgramFiles%\WindowsPowerShell\Modules` folder that is accessible by all users.

```PowerShell
PS > Install-AWSToolsModule AWS.Tools.IdentityManagement -Scope AllUsers
```
To install other modules, run similar commands with the appropriate module names, as found in the [PowerShell Gallery](https://www.powershellgallery.com/packages?q=aws).

### Install AWSPowerShell.NetCore on Windows

You can install the AWSPowerShell.NetCore on computers that are running Windows with PowerShell version 3 through 5.1, or PowerShell Core 6.0 or later.

You can install AWSPowerShell.NetCore in one of two ways

- Downloading the module from [AWSPowerShell.NetCore.zip](https://sdk-for-net.amazonwebservices.com/ps/v4/latest/AWSPowerShell.NetCore.zip) and extracting it in one of the module directories. You can discover your module directories by displaying the value of the `PSModulePath` environment variable.

- Installing from the PowerShell Gallery using the `Install-Module` cmdlet, as described in the following procedure.

**To install AWSPowerShell.NetCore from the PowerShell Gallery using the Install-Module cmdlet**

To install the AWSPowerShell.NetCore from the PowerShell Gallery, your computer must be running PowerShell 5.0 or later, or running PowerShellGet on PowerShell 3 or later. Run the following command.

```PowerShell
PS > Install-Module -name AWSPowerShell.NetCore
```
If you're running PowerShell as administrator, the previous command installs AWS Tools for PowerShell for all users on the computer. If you're running PowerShell as a standard user without administrator permissions, that same command installs AWS Tools for PowerShell for only the current user.

To install for only the current user when that user has administrator permissions, run the command with the `-Scope CurrentUser` parameter set, as follows.

```PowerShell
PS > Install-Module -name AWSPowerShell.NetCore -Scope CurrentUser
```
Although PowerShell 3.0 and later releases typically load modules into your PowerShell session the first time you run a cmdlet in the module, the AWSPowerShell.NetCore module is too large to support this functionality. You must instead explicitly load the AWSPowerShell.NetCore Core module into your PowerShell session by running the following command.

```PowerShell
PS > Import-Module AWSPowerShell.NetCore
```
To load the AWSPowerShell.NetCore module into a PowerShell session automatically, add that command to your PowerShell profile.

## Clean installation of AWSPowerShell.NetCore Module
Check if any AWS Modules are already installed and remove them. Only a single version of a single variant of AWS Tools for PowerShell (AWSPowerShell, AWSPowerShell.NetCore or 
AWS.Tools.Common) can be imported at any time.

Make sure to run these commands in an elevated PowerShell session (Run as Administrator) to ensure you have the necessary permissions for installing and uninstalling modules.

List all installed AWS modules:

```PowerShell
Get-Module -Name AWS* -ListAvailable | Select-Object Name, Version, Path
```
Remove all installed AWS modules:
```PowerShell
Get-Module -Name AWS* -ListAvailable | Uninstall-Module -Force
```
After removing the existing AWS modules, you can then install the AWSPowerShell.NetCore module:

```PowerShell
Install-Module -Name AWSPowerShell.NetCore -Force -AllowClobber
```
To list the commands available in the module:

```PowerShell
Get-Command -Module AWSPowerShell.NetCore
```

After the successful installation, you can use the AWSPowerShell.NetCore module in your scripts

```PowerShell
# Import AWSPowerShell.NetCore
Import-Module AWSPowerShell.NetCore

# Your AWS-related scripts...
```

To check the list of commands availble in a module

```PowerShell
Get-Command -Module AWSPowerShell.NetCore
```
