param(
  $outputFile = "./azure-resources.csv"
)


$account = az account show | ConvertFrom-Json
Write-Host "Retrieving all resources for subscription: '$($account.name)':$($account.id)"
Write-Host "Output File: $outputFile"

$headers = "Name,ResourceGroup,Location,Type,CreatedTimeUTC,ChangedTimeUTC"
$rawList = az resource list --query '[].{Name:name,ResourceGroup:resourceGroup,Location:location,Type:type,CreatedTime:createdTime,ChangedTime:changedTime}' -o tsv
$csvList = $rawList | % {$_ -replace  ("`t", ",")}
$headers > $outputFile
$csvList >> $outputFile

