param(
[Parameter(Mandatory = $true)]
$subscriptionId,

[Parameter(Mandatory = $true)]
$principalName
)

$graphApiId="00000003-0000-0000-c000-000000000000"
$azureAdApiId="00000002-0000-0000-c000-000000000000"

$graphApiDirectoryReadAllPermissionRoleId="7ab1d382-f21e-4acd-a863-ba3e13f7da61=Role"
$graphApiUserReadAllPermissionRoleId="df021288-bdef-4463-88db-98f22de89214=Role"
$graphApiGroupReadAllPermissionRoleId="5b567255-7703-4780-807c-7be8301ae99b=Role"
$azureADDirectoryReadAllPermissionRoleId="5778995a-e1bf-45b8-affa-663a9f3f4d04=Role"

Write-Host "> Creating service principal for Role based access control against subscription: $subscriptionId"
$secrets=(az ad sp create-for-rbac --name $principalName --role reader --scopes /subscriptions/$subscriptionId --sdk-auth | ConvertFrom-Json)


Write-Host "> Adding Graph API permission to read directory, users and groups ..."
az ad app permission add --id $secrets.clientId --api $graphApiId --api-permissions $graphApiUserReadAllPermissionRoleId $graphApiGroupReadAllPermissionRoleId $graphApiDirectoryReadAllPermissionRoleId
Write-Host "> Adding Azure AD API permission to read directory ..."
az ad app permission add --id $secrets.clientId --api $azureAdApiId --api-permissions $azureADDirectoryReadAllPermissionRoleId
Write-Host "> Granting Graph API permission with no expiry..."
az ad app permission grant --id $secrets.clientId --api $graphApiId --expires never --output none
Write-Host "> Granting Azure AD API permission with no expiry..."
az ad app permission grant --id $secrets.clientId --api $azureAdApiId --expires never --output none
Write-Host "> Applying admin consent..."
az ad app permission admin-consent --id $secrets.clientId
Write-Host "Done"
Write-Host ""

Write-Host "## Important! Copy these values. You will not be able to retrieve them later ##"
Write-Host "Client Id:     " $secrets.clientId
Write-Host "Client Secret: " $secrets.clientSecret
Write-Host "Tenant Id:     " $secrets.tenantId
