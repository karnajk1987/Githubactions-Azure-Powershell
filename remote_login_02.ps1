$vmName = 'AZ-VM-00-0'
$resourceGroupName = 'webapp-prod-p01'

# Get the private IP address of the virtual machine
$privateIpAddress = (Get-AzNetworkInterface -ResourceGroupName $resourceGroupName -Name ($vmName + '-nic')).IpConfigurations.PrivateIpAddress

# Create a new PSSession to the virtual machine using its private IP address
$session = New-PSSession -ComputerName $privateIpAddress -Credential (Get-Credential)

# Use Invoke-Command to run a PowerShell command on the remote session
Invoke-Command -Session $session -ScriptBlock {Get-Service win*}

# Close the PSSession
Remove-PSSession $session
