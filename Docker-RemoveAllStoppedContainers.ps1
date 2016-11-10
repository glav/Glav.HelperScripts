#remove all stopped containers
docker ps -a | foreach { if ($_ -inotmatch "CONTAINER ID") { docker rm  $_.Split(' ')[0] }} 
