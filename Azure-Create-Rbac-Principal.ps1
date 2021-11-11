param(
$subscriptionId,

[Parameter(Mandatory = $true)]
$principalName


)

if ($null -eq $subscriptionId -or $subscriptionId -eq "")
{
    Write-Host "Subscription ID not provided, using current context if it exists.."
    $currentAcct = (az account show) | ConvertFrom-Json
    if ($null -eq $currentAcct -or $null -eq $currentAcct.id)
    {
      Write-Host "No subscription context available for use. Exiting."
      return;
    }
    $subscriptionId = $currentAcct.id
}

Write-Host "Using subscription: $subscriptionId"

az ad sp create-for-rbac --name $principalName --role contributor --scopes /subscriptions/$subscriptionId --sdk-auth

Write-Host "Created Service Principal: '$principalName' with contributor role in Subscription: $subscriptionId ."