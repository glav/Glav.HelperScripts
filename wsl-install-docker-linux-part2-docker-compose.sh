#!/bin/bash

# NOTE: Taken from https://dev.to/felipecrs/simply-run-docker-on-wsl2-3o8

# Ensures not older packages are installed
sudo apt-get remove docker docker-engine docker.io containerd runc

# Ensure pre-requisites are installed
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Adds docker apt repository
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Adds docker apt key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Refreshes apt repos
sudo apt-get update

# Installs Docker CE
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Ensures docker group exists
sudo groupadd docker

# Ensures you are part of it
sudo usermod -aG docker $USER

# If running Ubuntu 22.04
#sudo update-alternatives --set iptables /usr/sbin/iptables-legacy

# Now, close your shell and open another for taking the group changes into account
exit
