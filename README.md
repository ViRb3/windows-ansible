# Windows Ansible

> Ansible playbook to configure a Windows machine

## Introduction

This Ansible playbook will apply my personal settings to any Windows 10 machine.
The default configuration is intended for a consumer deployment, but you can tweak it from [inventory.ini](inventory.ini).

## Usage

1. Enable WinRM using the [EnableWinRM.ps1](EnableWinRM.ps1) script.

   > NOTE: The script will temporarily set the current user's password to `1234` if none is present

2. Configure [inventory.ini](inventory.ini)

3. Run this Ansible playbook:

   ```bash
   bash ./setup-windows.sh
   ```

4. _(optional)_ Revert all WinRM changes:

   - Disable WinRM using [DisableWinRM.ps1](DisableWinRM.ps1) on your desktop. The temporary password (if present) will be removed.
   - Remove the `HTTPS WinRM` user rule in `simplewall` (if installed)

5. Restart the system for all changes to take effect

## Ansible environment variables

```json
{
  "ALLUSERSPROFILE": "C:\\ProgramData",
  "APPDATA": "C:\\Users\\Admin\\AppData\\Roaming",
  "COMPUTERNAME": "DESKTOP-1234567",
  "ComSpec": "C:\\Windows\\system32\\cmd.exe",
  "CommonProgramFiles": "C:\\Program Files\\Common Files",
  "CommonProgramFiles(x86)": "C:\\Program Files (x86)\\Common Files",
  "CommonProgramW6432": "C:\\Program Files\\Common Files",
  "DriverData": "C:\\Windows\\System32\\Drivers\\DriverData",
  "HOMEDRIVE": "C:",
  "HOMEPATH": "\\Users\\Admin",
  "LOCALAPPDATA": "C:\\Users\\Admin\\AppData\\Local",
  "LOGONSERVER": "\\\\DESKTOP-1234567",
  "NUMBER_OF_PROCESSORS": "4",
  "OS": "Windows_NT",
  "OneDrive": "C:\\Users\\Admin\\OneDrive",
  "PATHEXT": ".COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.CPL",
  "PROCESSOR_ARCHITECTURE": "AMD64",
  "PROCESSOR_IDENTIFIER": "Intel64 Family 6 Model 71 Stepping 1, GenuineIntel",
  "PROCESSOR_LEVEL": "6",
  "PROCESSOR_REVISION": "4701",
  "PROMPT": "$P$G",
  "PSExecutionPolicyPreference": "Unrestricted",
  "PSModulePath": "C:\\Users\\Admin\\Documents\\WindowsPowerShell\\Modules;C:\\Program Files\\WindowsPowerShell\\Modules;C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\Modules",
  "PUBLIC": "C:\\Users\\Public",
  "Path": "C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\Users\\Admin\\AppData\\Local\\Microsoft\\WindowsApps",
  "ProgramData": "C:\\ProgramData",
  "ProgramFiles": "C:\\Program Files",
  "ProgramFiles(x86)": "C:\\Program Files (x86)",
  "ProgramW6432": "C:\\Program Files",
  "SystemDrive": "C:",
  "SystemRoot": "C:\\Windows",
  "TEMP": "C:\\Users\\Admin\\AppData\\Local\\Temp",
  "TMP": "C:\\Users\\Admin\\AppData\\Local\\Temp",
  "USERDOMAIN": "DESKTOP-1234567",
  "USERDOMAIN_ROAMINGPROFILE": "DESKTOP-1234567",
  "USERNAME": "Admin",
  "USERPROFILE": "C:\\Users\\Admin",
  "windir": "C:\\Windows"
}
```
