param ([int]$port = 81)

Write-Host "Staring NGinx container on port:$port"
#run nginx on port 81 point to port 8o within the container
docker run -d -p $port":"80 --name webserver nginx
#docker run -d -p "$port":80 --name webserver nginx
Write-Host "Done"