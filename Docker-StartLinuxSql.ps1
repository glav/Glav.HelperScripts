"Starting Miscrosoft SQL Server Linux container"

set-item -path env:SA_PASSWORD -value MyP@ssw0rd!
$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path

$composeLocation = $directorypath + "/LinuxSqlCompose"
cd $composeLocation
docker-compose up
Write-Output "Started with Password 'MyP@ssw0rd!'"
