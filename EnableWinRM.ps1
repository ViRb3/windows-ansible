# Set-Service always makes it "Automatic (Delayed start)"
cmd /c "sc config winrm start=auto"
Start-Service -Name "WinRM"

# Remove old listeners
Remove-Item -Path WSMan:\localhost\Listener\* -Recurse -Force

$Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "packer"
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint -Force

winrm quickconfig -q
winrm set "winrm/config/service/auth" '@{Basic="true"}'
winrm set "winrm/config/client/auth" '@{Basic="true"}'
winrm set "winrm/config/listener?Address=*+Transport=HTTPS" "@{Port=`"5986`";Hostname=`"packer`";CertificateThumbprint=`"$($Cert.Thumbprint)`"}"

# https://github.com/ansible/ansible/issues/42978
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1

Remove-NetFirewallRule -DisplayName "HTTPS WinRM" -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "HTTPS WinRM" -Group "Remote Management" -Direction Inbound -LocalPort 5986 -Protocol TCP -Action Allow

$username = $env:UserName
$password = New-Object System.Security.SecureString
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
try {
    Start-Process -FilePath cmd.exe /c -Credential $psCred
}
catch {
    Write-Host "Found no password for current user '$username', temporarily setting it to '1234' for WinRM to work"
    Set-LocalUser -Name $username -Password (ConvertTo-SecureString -AsPlainText "1234" -Force) -Description "WINRM-REMOVE-ME"
}
