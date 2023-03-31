#Connect-AzAccount

# Select-AzSubscription -SubscriptionId "58f58984-c7ec-4128-9dcf-9b5d77697c3d"

$resourceGroupName = 'webapp-dev'
$location = 'eastus'
$vmName = 'webapp-dev-wind-01'
$snapshotName = 'webapp-dev-wind-01-image-backup-03'
$resourceGroupName2 = 'webapp-qa'


$vm = Get-AzVM `
    -ResourceGroupName $resourceGroupName `
    -Name $vmName



$snapshot = New-AzSnapshotConfig `
    -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id `
    -Location $location `
    -CreateOption copy



New-AzSnapshot `
    -Snapshot $snapshot `
    -SnapshotName $snapshotName `
    -ResourceGroupName $resourceGroupName2
