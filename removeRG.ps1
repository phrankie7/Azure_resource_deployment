
# Name of the resource group you want to delete.
$ResourceGroupName = "demo-RG1"

# Delete the resource group and its resources
Remove-AzResourceGroup -Name $ResourceGroupName -Force -Confirm:$false
