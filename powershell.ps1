# Define the resource IDs of the VMs and NICs to delete
$vmResourceIds = @(
#     "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-dev-rg/providers/Microsoft.Compute/virtualMachines/webapp-vm-01",
#     "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-dev-rg/providers/Microsoft.Network/networkInterfaces/webapp-vm-01346",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-dev-rg/providers/Microsoft.Compute/virtualMachines/webapp-vm-02",
    "/subscriptions/58f58984-c7ec-4128-9dcf-9b5d77697c3d/resourceGroups/webapp-dev-rg/providers/Microsoft.Network/networkInterfaces/webapp-vm-02670"
)

# Loop through the resource IDs and delete the VMs and NICs
foreach ($resourceId in $vmResourceIds) {
    # Check if the resource is a VM or NIC
    if ($resourceId.Contains("/virtualMachines/")) {
        # Extract the VM name from the resource ID
        $vmName = ($resourceId -split '/')[-1]
        # Get the VM object
        $vm = Get-AzVM -ResourceGroupName webapp-dev-rg -Name $vmName
        # Remove the NIC from the VM
        $nicId = $vm.NetworkProfile.NetworkInterfaces[0].Id
        $vm = Remove-AzVMNetworkInterface -VM $vm -Id $nicId
        # Update the VM
        Update-AzVM -ResourceGroupName webapp-dev-rg -VM $vm -Verbose -AsJob
    } elseif ($resourceId.Contains("/networkInterfaces/")) {
        # Extract the NIC name from the resource ID
        $nicName = ($resourceId -split '/')[-1]
        # Delete the NIC
        Remove-AzNetworkInterface -ResourceGroupName webapp-dev-rg -Name $nicName -Force
    } else {
        Write-Host "Unknown resource type: $resourceId"
    }
}
