#set $id to 1st container id in list
docker ps | foreach { if ($_ -inotmatch "CONTAINER ID") { $id = $_.Split(' ')[0] }} 
$id
