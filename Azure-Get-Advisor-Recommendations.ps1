param(
  $outputFile = "./azure-recommendations.csv"
)

# [Parameter(Mandatory = $true)]
# $principalName
# )


$account = az account show | ConvertFrom-Json
Write-Host "Retrieving recommendations for subscription: '$($account.name)':$($account.id)"
Write-Host "Output File: $outputFile"

$jsonResult = az advisor recommendation list --query '[].{sku: extendedProperties.displaySKU, category:category, impact:impact, problem: shortDescription.problem, annualSavings: extendedProperties.annualSavingsAmount, currency: extendedProperties.savingsCurrency, resourceGroup: resourceGroup, resourceType: impactedField, name: impactedValue}' | ConvertFrom-Json
Foreach ($item IN $jsonResult) {
  if ($nul -ne $item.resourceGroup -and $nul -ne $item.resourceType -and $nul -ne $item.name) {
    # $itemDetail = az resource show -g $item.resourceGroup -n $item.name --resource-type $item.resourceType | ConvertFrom-Json
    # $item.itemDetail = $itemDetail
  }
}

$jsonResult | Export-Csv -Path $outputFile