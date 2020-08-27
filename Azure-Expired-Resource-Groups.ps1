
param (
    # Indicates if the resources are listed (default) or actually deleted if expired.
    [switch]
    $DeleteIfExpired,

    # doesn't work
    [switch]
    $Verbose
)

function Log
{
    param ([string]$msg, [bool]$IsVerboseOutput=$false)

    if (($IsVerboseOutput -eq $true -and $Verbose -eq $true) -or $IsVerboseOutput -eq $false )    {
        Write-Host $msg
    }
}


$action = 'Listing'
if ($DeleteIfExpired -eq $true) {$action = 'Deleting'}

Write-Host "$action Expired resources..."
Write-Host "Verbose output: $Verbose"
Write-Host '' 

$now = [System.DateTime]::Now
Log "Current Date/Time: $now" $true
Log 'Getting list of resource groups...' $true

$rgs=(az group list --query "[].{name:name,tags:tags}") | ConvertFrom-Json
foreach ($rg in $rgs) {
    
    $rgName = $rg.name
    
    Log "Checking Resource group [$rgName]" $true
    #Write-Host "Checking Resource group [" $rg.name "]"
    if ($rg.tags.count -gt 0 ) {
        
        foreach ($tag in $rg.tags) {
            if ($tag.expiresOn -ne $null) {
                $expiry = [System.DateTime]::ParseExact($tag.expiresOn.Trim(),'yyyy-MM-dd',$null)
                if ($expiry -lt $now) {
                    Write-Host "$rgName has an expiry date of $expiry and has expired." -ForegroundColor Red
                    if ($DeleteIfExpired -eq $true) {
                        Write-Host "  >> Deleting: $rgName" -ForegroundColor red
                        az group delete --name $rg.name --yes
                    }
                }
            }
        }
    }
}