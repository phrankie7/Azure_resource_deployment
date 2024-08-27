# Connect-AzAccount
#Connect-AzAccount

# Set the resource group name and location for your server
$resourceGroupName = "demo-RG1"
$location = "East US"

#Check for existing or duplicate Resource Group.

$existingResourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue

if (-not $existingResourceGroup) {
    Write-Host "Error: Resource group '$ResourceGroupName' does not exist."
    #exit
}

# Create a resource group
$resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location


# Set an admin login and password for your server
$adminSqlLogin = "SqlAdmin"
$password = "ChangeYourAdminPassword1"

# Convert the SqlAdminPassword to a SecureString
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force




# The sample database name
$databaseName = "myDemoDatabase"

# Set server name - the logical server name has to be unique in the system
$serverName = "server-$(Get-Random)"


<#
# The ip address range that you want to allow to access your server
$startIp = "0.0.0.0"
$endIp = "0.0.0.0"

# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId

#>

# Create a server with a system wide unique server name
$SqlServer = New-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $serverName -Location $Location -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $securePassword)

# Create a server firewall rule that allows access from the specified IP range
#$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $serverName -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName -RequestedServiceObjectiveName "S0" -SampleName "AdventureWorksLT"


# Output success message
Write-Host "SQL Server '$serverName' and Database '$databaseName' created successfully."


