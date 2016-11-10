#set $id to 1st container id in list
docker ps | foreach { if ($_ -inotmatch "CONTAINER ID") { $id = $_.Split(' ')[0] }} 

write-host "First container id is [$id]"
write-host "and is assigned to variable" $"id"
