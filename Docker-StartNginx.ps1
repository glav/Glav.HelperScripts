param ([int]$port = 81)

"Staring NGinx container on port:$port"
#run nginx on port 81 point to port 8o within the container
docker run -d -p $port":"80 --name nginxwebserver nginx
"Done"