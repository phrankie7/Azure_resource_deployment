
# Connect to Azure AD (you will be prompted to sign in)
#Connect-AzAccount

# Define user details
$displayName = "John Doe"
$userPrincipalName = "john@gridstone77.onmicrosoft.com"
$userName = "john"
$password = "Demo1234!"  # Replace with a secure password

# Convert the password to a SecureString
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

# Create the new user
New-AzADUser -DisplayName $displayName -UserPrincipalName $userPrincipalName -MailNickname $userName -Password $securePassword -AccountEnabled $true 
