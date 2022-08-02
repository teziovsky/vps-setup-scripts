#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
sudo apt-get update -qq -y && sudo apt-get upgrade -qq -y
echo
echo "System updated! 🎉"

# INSTALL GIT
sudo apt-get install -qq git -y
echo
echo "Git installed 🎉"

sudo git clone https://github.com/teziovsky/vps-setup-scripts.git /opt/vps-setup-scripts

cd /opt/vps-setup-scripts