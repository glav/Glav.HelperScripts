Write-Host "Starting Azure CLI in docker container."
Write-Host "Note: No volumes have been mounted so changes will be lost"

docker run  -it azuresdk/azure-cli-python
