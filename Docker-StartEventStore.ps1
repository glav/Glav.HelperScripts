Write-Host "Note: If you receive an error, you may need to remove a named stopped container called 'eventstore-node'".
docker run --name eventstore-node -it -p 2113:2113 -p 1113:1113 -e EVENTSTORE_DEV=true -e EVENTSTORE_INSECURE=true eventstore/eventstore
