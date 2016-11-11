#To Start elastic search and expose host (my machine) port 9200 mapping to container port 9200
#Note: 9200:9200 ports are HostPort:ContainerPort format

"Starting Elastic Search container on port 9200"
docker run -d -p 9200:9200 elasticsearch
"Done."