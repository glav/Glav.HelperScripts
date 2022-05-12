param
(
    [parameter(Mandatory = $true)][string]$ResourceGroupName
    , [parameter(Mandatory = $true)][string]$ServerName
    , [parameter(Mandatory = $true)][string]$DatabaseName
)

Write-Host "Ensure you are logged in via Connect-AzAccount and the context is set correctly via Set-AzContext. Listing context..."
Get-AzContext

$Operation = Get-AzSqlDatabaseActivity -ResourceGroupName $ResourceGroupName -ServerName $ServerName -DatabaseName $DatabaseName | Where-Object { ($_.Operation -like "Export*" -or $_.Operation -like "Import*") -and $_.State -eq "InProgress" }
    
if (-not [string]::IsNullOrEmpty($Operation)) {
    do {
        Write-Host -ForegroundColor Cyan ("Operation " + $Operation.Operation + " with OperationID: " + $Operation.OperationId + " is now " + $Operation.State)
        $UserInput = Read-Host -Prompt "Should I cancel this operation? (Y/N)"
    } while ($UserInput -ne "Y" -and $UserInput -ne "N")

    if ($UserInput -eq "Y") { 
        "Canceling operation"
        Stop-AzSqlDatabaseActivity -ResourceGroupName $ResourceGroupName -ServerName $ServerName -DatabaseName $DatabaseName -OperationId $Operation.OperationId
    }
    else 
    { "Exiting without cenceling the operation" }
        
}
else {
    "No import or export operation is now running"
}
