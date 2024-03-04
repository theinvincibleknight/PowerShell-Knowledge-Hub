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
