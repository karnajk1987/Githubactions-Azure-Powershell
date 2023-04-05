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
    $nic = Get-AzNetworkInterface -ResourceId $nicResourceId
    $vm = Get-AzVM -ResourceGroupName $nic.ResourceGroupName -Name $nic.VirtualMachine.name
    Stop-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Force
}
