# Replace the values below with your own credentials and VM details
$vmPrivateIP = "10.1.1.4"
$username = "adminuser"
$password = "P@$$w0rd1234!"
$newUsername = "adminuser-1"
$newPassword = "P@$$w0rd1234!"

# Create a credential object for authentication
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Connect to the VM using RDP
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Terminal Server Client" -Name "AuthenticationLevelOverride" -Value 0
mstsc.exe /v:$vmPrivateIP /admin /f

# Wait for the RDP session to be established
Start-Sleep -Seconds 10

# Create a new local user account in the VM
$newUser = New-LocalUser -Name $newUsername -Password (ConvertTo-SecureString $newPassword -AsPlainText -Force) -FullName "New User"
Add-LocalGroupMember -Group "Administrators" -Member $newUsername

# Close the RDP session
cmd.exe /c "echo off | tscon.exe %sessionname% /dest:console"

# Disconnect from the VM
exit
