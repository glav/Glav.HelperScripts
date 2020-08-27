param(
[Parameter(Mandatory = $true)]
$principalNameToFind
)

Write-Host "Searching for Service Principals with name containing [$principalNameToFind]..."
az ad sp list --query "[?contains(displayName,'$principalNameToFind')].{name:displayName, id:objectId}" --all 