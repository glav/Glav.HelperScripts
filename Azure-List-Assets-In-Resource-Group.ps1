#Getting all resources within a resource group
param ([string]$resourceGroupName)

if ($resourceGroupName -eq "") {
    write-Host "Must specify a resource group name."
} else {
    Get-AzureRmResource | foreach { if ($_.ResourceGroupName -eq $resourceGroupName) { $_  }} 
}