# PowerShell Module Troubleshooting Documentation

This document provides a comprehensive guide for troubleshooting PowerShell modules. Follow the steps below to diagnose and resolve common issues related to PowerShell module installation and importation.

## 1. Check PowerShell Version

Before troubleshooting modules, ensure that you are using a compatible version of PowerShell. Some modules may require a specific version to function correctly.

```powershell
$PSVersionTable.PSVersion
```

## 2. Check Execution Policy

PowerShell's execution policy determines whether scripts can run on your system. If the policy is set to `Restricted`, you may not be able to run scripts or import modules.

```powershell
Get-ExecutionPolicy
```

If it's set to `Restricted`, you can change it to `RemoteSigned` or `Unrestricted` (if appropriate for your environment) using:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 3. Install Any Module

To install a PowerShell module, use the following command. Replace `<ModuleName>` with the name of the module you wish to install.

```powershell
Install-Module -Name <ModuleName> -Scope CurrentUser
```

## 4. Import the Module

After installation, you need to import the module into your PowerShell session to use its cmdlets.

```powershell
Import-Module <ModuleName>
```

## 5. Verify Installation

To confirm that the module has been installed correctly, you can check for its commands using:

```powershell
Get-Command <ModuleName>
```

## 6. If You Have Installed the Module but Are Unable to Import It

### Verify Module Path

First, ensure that the module is indeed located in the expected directory. You can check the contents of the module directory with the following command:

```powershell
Get-ChildItem "C:\Users\Documents\WindowsPowerShell\Modules\ImportExcel\7.8.10"
```

### Try Importing the Module Explicitly

If the module is present, try importing it explicitly by using the full path. Run the following command:

```powershell
Import-Module "C:\Users\Documents\WindowsPowerShell\Modules\ImportExcel\7.8.10\ImportExcel.psd1"
```

### Check for Errors

If the import fails, check for any error messages that might provide more context. You can also try running:

```powershell
$Error[0] | Format-List -Force
```

## 7. Reinstall the Module

If none of the above steps work, you might want to try uninstalling and then reinstalling the module:

```powershell
Uninstall-Module -Name <ModuleName> -AllVersions -Force
Install-Module -Name <ModuleName> -Scope CurrentUser
```

## 8. Check Module Path in PowerShell

You can check the paths where PowerShell looks for modules by running:

```powershell
$env:PSModulePath -split ';'
```

Ensure that the path to your module is included in the output. If it is not, you can add it temporarily for the current session:

```powershell
$env:PSModulePath += ";C:\Users\Documents\WindowsPowerShell\Modules"
```

## 9. Reverify if Path is Added in Module Path

After adding the path, verify that it has been included successfully:

```powershell
$env:PSModulePath -split ';'
```

Once you see the module path is properly added, you can attempt to import the module again:

```powershell
Import-Module <ModuleName>
```

## 10. Check for Module Manifest

If the module still does not load, check the contents of the `ImportExcel.psd1` file to ensure it is not corrupted. You can open it in a text editor to see if it looks like a valid module manifest.

## 11. Check for Multiple Versions

If you have multiple versions of the module installed, it might cause conflicts. You can check for installed versions with:

```powershell
Get-Module -ListAvailable ImportExcel
```

If you see multiple versions, you can specify the version you want to import:

```powershell
Import-Module ImportExcel -RequiredVersion <version_number>
```

## 12. Ensure Module Path Visibility

When you install a PowerShell module, it will be installed in a local path. Check if that path is visible in the `PSModulePath`. If not, you can add it. Once the module path is set, you should be able to import the installed modules.

## 13. Make the Change Permanent (Optional)

If you want to make this change permanent (so you don't have to add the path every time you start PowerShell), you can add the path to your PowerShell profile. You can edit your profile with the following command:

```powershell
notepad $PROFILE
```

If the file does not exist, you may be prompted to create it. Add the following line to the profile script:

```powershell
$env:PSModulePath += ";C:\Users\Documents\WindowsPowerShell\Modules"
```

Save and close the file. The next time you start PowerShell, the path will be included automatically, allowing you to import your modules without needing to set the path each time.
