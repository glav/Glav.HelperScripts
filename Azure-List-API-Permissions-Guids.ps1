param(
[Parameter(Mandatory = $false)]
[Switch]
$showDelegatedScopes = $true,

[Parameter(Mandatory = $false)]
[Switch]
$showAppRoles = $true,


[Parameter(Mandatory = $false)]
[Switch]
$showLegacyApis = $false
)

Write-Host ">> Listing Requested API Permission Guids"
Write-Host "> Showing Microsoft Graph API delegated Scopes: " $showDelegatedScopes
Write-Host "> Showing Microsoft Graph API App Roles: " $showAppRoles
Write-Host "> Showing Legacy Azure AD API Roles: " $showLegacyApis
Write-Host ""

if ($showDelegatedScopes)
{
	Write-Host "Listing Microsoft Graph API Permission Scope Guids"
	Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	az ad sp list --filter "displayName eq 'Microsoft Graph'" --query '[].oauth2Permissions[].{Value:value, Id:id, UserConsentDisplayName:userConsentDisplayName}' -o table
	Write-Host ""
}

if ($showAppRoles)
{
	Write-Host "Listing Microsoft Graph API Permission Application Role Guids"
	Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	az ad sp list --filter "displayName eq 'Microsoft Graph'" --query '[].appRoles[].{Value:value, Id:id, UserConsentDisplayName:userConsentDisplayName}' -o table
	Write-Host ""
}

if ($showLegacyApis)
{
	Write-Host "Listing Azure Active Directory Legacy API Permission Guids"
	Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	az ad sp list --filter "displayName eq 'Microsoft.Azure.ActiveDirectory'" --query '[].oauth2Permissions[].{Value:value, Id:id, UserConsentDisplayName:userConsentDisplayName}' -o table
	Write-Host ""
}
