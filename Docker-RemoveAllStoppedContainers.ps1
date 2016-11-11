#remove all stopped containers
"Removing any stopped containers..."
docker ps -a | foreach { if ($_ -inotmatch "CONTAINER ID") { docker rm  $_.Split(' ')[0] }} 
"Done"