param(
    [String]$ResourceGroupName,
    [String]$Location,
    [String[]]$VMNames
)

# Authenticate to Azure (you may need to install and import the Azure PowerShell module)
Connect-AzAccount

# Create a resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Loop through VM names and deploy virtual machines
foreach ($VMName in $VMNames) {
    $VMConfig = @{
        ResourceGroupName = $ResourceGroupName
        Name              = $VMName
        Location          = if ($VMName -eq "VM1") { "East US" } elseif ($VMName -eq "VM2") { "West US" } else { $Location }
        Image             = "Win2019Datacenter"
        Size              = "Standard_DS1_v2"
        Credential        = (Get-Credential)
    }

    New-AzVM @VMConfig
}


