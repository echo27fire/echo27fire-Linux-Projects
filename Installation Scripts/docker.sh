#!/bin/bash
# date: May 5, 2022
# Auth: Taylor G.
# docker install scirpt for Ubuntu/Debian distros


# vars
USER=$(whoami)

function docker-install () {
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt install docker-ce -y || echo "error installing docker"
}


function user-mod () {
sudo usermod -aG docker ${USER} || echo "error adding user to docker group"
groups
}

# pull up docker status
docker-install
user-mod
sudo systemctl status docker

