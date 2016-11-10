#remove all stopped containers
Write-Host "Removing any stopped containers..."
docker ps -a | foreach { if ($_ -inotmatch "CONTAINER ID") { docker rm  $_.Split(' ')[0] }} 
Write-Host "Done"