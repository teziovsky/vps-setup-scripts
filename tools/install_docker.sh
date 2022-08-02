#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# INSTALL DOCKER
if ! command -v docker &> /dev/null
then
    sudo apt update -y
    sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
    
    # Dodanie oficjalnego klucza GPG Dockera
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    # Dodanie oficjalnych repozytorium Dockera do systmeu
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt update -y
    # Instalacja dockera
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
    
    # Sprawdzenie czy Docker został prawidłowo zainstalowany
    docker run hello-world
else
    echo
    echo "Docker already installed 🎉"
fi
