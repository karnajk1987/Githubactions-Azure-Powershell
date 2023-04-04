# Specify the VM and NIC resource IDs
# Define the resource IDs of the NICs to delete
$nicResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-4"
    # Add additional NIC resource IDs here as needed
)
# Define the resource IDs of the VMs to delete
$vmResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-4"
    # Add additional VM resource IDs here as needed
)

# Get the VM
$vm = Get-AzVM -ResourceId $vmResourceId

# Dissociate each NIC from the VM
foreach ($nicResourceId in $nicResourceIds) {
    # Remove the NIC from the VM's list of NICs
    $vm.NetworkInterfaceIDs = $vm.NetworkInterfaceIDs | Where-Object { $_ -ne $nicResourceId }

    # Update the VM's configuration
    Set-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -VM $vm
}
