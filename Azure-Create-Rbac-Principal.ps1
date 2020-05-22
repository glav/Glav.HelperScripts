param(
[Parameter(Mandatory = $true)]
$subscriptionId,

[Parameter(Mandatory = $true)]
$principalName


)
az ad sp create-for-rbac --name $principalName --role contributor --scopes /subscriptions/$subscriptionId --sdk-auth