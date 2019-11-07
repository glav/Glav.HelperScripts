$rg="testauth"
$loc="AustraliaEast"
$plan="authplan"
$appname="testwebappauthstuff"
$adappname="testauthjunk"
$webUrl = "https://" + $appname + ".azurewebsites.net"
$replyUrl = $webUrl + "/.auth/login/aad/callback"

# Create the resource group, appservice plan and web app
Write-Host "--> Creating resource group"
az group create --name $rg --location $loc --output none
Write-Host "--> Creating appservice plan"
az appservice plan create --resource-group $rg --sku F1 --name $plan --output none
Write-Host "--> Creating appservice/webapp"
az webapp create --resource-group $rg --plan $plan --name $appname --output none

# Ensure we have an app registration
Write-Host "--> Registering application and adding credential/secret"
$adAppId = az ad app create --display-name $adappname --identifier-uris $webUrl --reply-urls $replyUrl --query appId --homepage $webUrl
Write-Host "Registered app id: $adAppId"
# create a new client id and secret
$appSecret = (az ad app credential reset --id $adAppid  | ConvertFrom-Json)  #Note: Adding --reset argument here resets all secrets. Use --append to add a new one each time.

# these are the API resource id (Graph) and associated permission/scope
$apiResourceAppId = "00000003-0000-0000-c000-000000000000"
$openIdApiPermission = "37f7f235-527c-4136-accd-4a02d197296e=Scope"
#Write-Host "Granting permission"
#az ad app permission grant --id $adAppid --api 00000003-0000-0000-c000-000000000000 --expires never
Write-Host "--> Adding permission scope"
az ad app permission add --id $adAppid --api $apiResourceAppId  --api-permissions $openIdApiPermission --output none
Write-Host "--> Permission scope added"
#az ad app permission grant --id $adAppid --api $apiResourceAppId

# Get the issuer Url by getting the cloud details and metadata for this tenant
Write-Host "--> Getting issuer Url"
$cloudDetails = (az cloud show | ConvertFrom-Json)
$metadataurl = $cloudDetails.endpoints.activeDirectory + "/" + $appSecret.tenant + "/.well-known/openid-configuration"
$metadata = (Invoke-WebRequest -Uri $metadataurl | ConvertFrom-Json)

#Finally update the webapp with the required app service authentication to AAD
# Note: Requires MicrosoftGraph OpenId delegated permission
Write-Host "--> Setting AppService auth settings on webapp"
az webapp auth update --resource-group $rg --name $appname --enabled true --action LoginWithAzureActiveDirectory --aad-client-id $appSecret.appId  --aad-client-secret $appSecret.password --aad-token-issuer-url $metadata.issuer --aad-allowed-token-audiences $webUrl --allowed-external-redirect-urls $webUrl
