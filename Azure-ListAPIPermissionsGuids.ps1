Write-Host "Listing Microsoft.Graph API Permission Guids"
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

az ad sp list --filter "displayName eq 'Microsoft Graph'" --query '[].oauth2Permissions[].{Value:value, Id:id, UserConsentDisplayName:userConsentDisplayName}' -o table