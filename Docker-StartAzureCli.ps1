"Staring Azure CLI using local/host system .ssh RSA file"

#run the azure CLI image in interactive mode, but mounting the local system RSA keys to the container
docker run -it -v C:/Users/glav/.ssh:/root/.ssh azuresdk/azure-cli-python
