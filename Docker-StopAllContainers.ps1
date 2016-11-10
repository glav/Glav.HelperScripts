#stop all containers
docker ps | foreach { if ($_ -inotmatch "CONTAINER ID") { docker stop $_.Split(' ')[0] }} 
