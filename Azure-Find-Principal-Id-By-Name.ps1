param(
[Parameter(Mandatory = $true)]
$principalNameToFind
)

Write-Host "Searching for Service Principal with name equal to [$principalNameToFind]..."
$result=(az ad sp list --all --query "[?displayName == '$principalNameToFind'].{name:displayName, id:objectId}" | ConvertFrom-Json)
if (!$result)
{
   Write-Host "Not found"
} else 
{
   Write-Host $result.id
}
