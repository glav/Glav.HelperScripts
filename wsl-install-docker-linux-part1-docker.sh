#!/bin/bash

# NOTE: Taken from https://dev.to/felipecrs/simply-run-docker-on-wsl2-3o8

# Finds the latest version
compose_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/compose/releases/latest | xargs basename)

# Downloads the binary to the plugins folder
curl -fL --create-dirs -o ~/.docker/cli-plugins/docker-compose \
    "https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-linux-$(uname -m)"

# Assigns execution permission to it
chmod +x ~/.docker/cli-plugins/docker-compose

# Finds the latest version
switch_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/compose-switch/releases/latest | xargs basename)

# Downloads the binary
sudo curl -fL -o /usr/local/bin/docker-compose \
    "https://github.com/docker/compose-switch/releases/download/${switch_version}/docker-compose-linux-$(dpkg --print-architecture)"

# Assigns execution permission to it
sudo chmod +x /usr/local/bin/docker-compose

# Finds the latest version
wincred_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/docker-credential-helpers/releases/latest | xargs basename)

# Downloads and extracts the .exe
sudo curl -fL \
    "https://github.com/docker/docker-credential-helpers/releases/download/${wincred_version}/docker-credential-wincred-${wincred_version}-$(dpkg --print-architecture).zip" |
    zcat | sudo tee /usr/local/bin/docker-credential-wincred.exe >/dev/null

# Assigns execution permission to it
sudo chmod +x /usr/local/bin/docker-credential-wincred.exe
