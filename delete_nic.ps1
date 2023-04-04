# Define the resource IDs of the NICs to delete
$nicResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-4"
    # Add additional NIC resource IDs here as needed
)

foreach ($nicResourceId in $nicResourceIds) {
    # Get the network interface
    $nic = Get-AzNetworkInterface -ResourceId $nicResourceId

    # If the network interface is associated with a virtual machine, dissociate it
    if ($null -ne $nic.VirtualMachine) {
        Remove-AzNetworkInterface -InputObject $nic -Force
    }

    # Delete the network interface
    Remove-AzNetworkInterface -ResourceId $nicResourceId -Force
}

# Define the resource IDs of the VMs to delete
$vmResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Compute/virtualMachines/AZ-VM-00-4"
    # Add additional VM resource IDs here as needed
)


foreach ($vmResourceId in $vmResourceIds) {
    Remove-AzVM -ResourceId $vmResourceId -Force
}
