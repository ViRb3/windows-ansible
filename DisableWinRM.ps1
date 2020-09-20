# Remove all listeners
Remove-Item -Path WSMan:\localhost\Listener\* -Recurse -Force

# Undo WinRM settings
winrm set "winrm/config/service/auth" '@{Basic="false"}'
winrm set "winrm/config/client/auth" '@{Basic="false"}'

# https://github.com/ansible/ansible/issues/42978
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 0

Remove-NetFirewallRule -DisplayName "HTTPS WinRM"

Set-Service -Name "WinRM" -StartupType Manual
Stop-Service -Name "WinRM"
