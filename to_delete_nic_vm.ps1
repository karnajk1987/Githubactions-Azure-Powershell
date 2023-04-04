# Define the resource IDs of the NICs to delete
$nicResourceIds = @(
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-0",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-1",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-2",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-3",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-prod-p01/providers/Microsoft.Network/networkInterfaces/AZ-VM-00-NIC-4"
    # Add additional NIC resource IDs here as needed
)

# Loop through the NIC resource IDs and delete each NIC
foreach ($nicResourceId in $nicResourceIds) {
    # Extract the NIC name from the resource ID
    $nicName = ($nicResourceId -split '/')[-1]
    # Delete the NIC
    Remove-AzNetworkInterface -ResourceGroupName webapp-prod-p01 -Name $nicName -Force
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

# Loop through the VM resource IDs and delete each VM
foreach ($vmResourceId in $vmResourceIds) {
    # Extract the VM name from the resource ID
    $vmName = ($vmResourceId -split '/')[-1]
    # Delete the VM
    Remove-AzVM -ResourceGroupName webapp-prod-p01 -Name $vmName -Force
}
