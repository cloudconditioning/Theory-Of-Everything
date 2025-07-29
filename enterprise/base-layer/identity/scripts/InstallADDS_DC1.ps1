# install-adds.ps1
# Purpose: Install AD DS and promote this Windows Server to a Domain Controller non-interactively

$domainName = "cloudconditioning.com"
$domainNetBIOS = "CLOUD"
$safeModePasswordPlain = "PrimeTime2025"

# Convert password to SecureString
$safeModePassword = ConvertTo-SecureString $safeModePasswordPlain -AsPlainText -Force

# Install AD DS role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote to Domain Controller and create a new forest non-interactively
Install-ADDSForest `
    -DomainName $domainName `
    -DomainNetbiosName $domainNetBIOS `
    -SafeModeAdministratorPassword $safeModePassword `
    -InstallDNS `
    -Force:$true `
    -NoRebootOnCompletion:$false
