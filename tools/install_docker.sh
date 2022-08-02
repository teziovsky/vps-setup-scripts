#!/bin/bash

# INSTALL DOCKER
if ! command -v docker &> /dev/null
then
    # Update the apt package index and install packages to allow apt to use a repository over HTTPS
    sudo apt-get update -qq -y
    sudo apt-get install -qq -y ca-certificates curl gnupg lsb-release

    # Add Docker’s official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Use the following command to set up the repository
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update the apt package index, and install the latest version of Docker Engine, containerd, and Docker Compose
    sudo apt-get update -qq -y
    sudo apt-get install -qq -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo groupadd docker

    sudo docker run hello-world

    echo
    echo "Docker installed 🎉"
    echo
    echo "Login again to complete installation!"
else
    sudo usermod -aG docker $USER
    echo
    echo "Docker already installed 👌"
fi
