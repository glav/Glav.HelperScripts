#set $id to 1st container id in list
docker ps | foreach { if ($_ -inotmatch "CONTAINER ID") { $id = $_.Split(' ')[0] }} 

Write-Host "First container id is [$id]"
Write-Host "and is assigned to variable" $"id"
