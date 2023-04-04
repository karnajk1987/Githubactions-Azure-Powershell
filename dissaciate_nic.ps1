# Set variables for the resource group and NIC resource ID
$rgName = "webapp-prod-p01"
$nicResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-4"
    # Add additional NIC resource IDs here as needed
)

# Get the network interface
$nic = Get-AzNetworkInterface -ResourceId $nicResourceId

# Get the virtual machines attached to the NIC
$vmIds = $nic.IpConfigurations | Select-Object -ExpandProperty VirtualMachine | Select-Object -ExpandProperty Id

# Dissociate the NIC from the virtual machines
foreach ($vmId in $vmIds) {
    $vm = Get-AzVM -ResourceId $vmId
    $vm.NetworkProfile.NetworkInterfaces.Remove($nic.Id)
    Update-AzVM -VM $vm -ResourceGroupName $rgName
}
