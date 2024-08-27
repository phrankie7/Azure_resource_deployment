
$AZADUsers = Import-Csv 'C:\Users\phran\Desktop\Azdemo\Newhires Demo - Sheet1.csv'

foreach ($User in $AZADUsers) {
    $displayName = $User.displayName
    $userPrincipalName = $User.userPrincipalName  
    $userName = $User.userName
    $password = $User.password
    $companyName = $User.companyName

    # Check if user with the same displayName already exists
if ((Get-AzADUser -Filter "displayName eq '$displayName'")) {
    Write-Warning "A user account with displayName '$displayName' already exists in Azure Active Directory."
}

    else {
        # Convert the password to a SecureString
        $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

        # Create the new user
        New-AzADUser -DisplayName $displayName -UserPrincipalName $userPrincipalName -MailNickname $userName -Password $securePassword -AccountEnabled $true
    }
}

