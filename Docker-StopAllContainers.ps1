#stop all containers

Write-Host "Stopping all containers (if any)"
docker ps | foreach { if ($_ -inotmatch "CONTAINER ID") { docker stop $_.Split(' ')[0] }} 
Write-Host "Done."