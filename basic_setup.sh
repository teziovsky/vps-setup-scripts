#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./utils/check_sudo.sh

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"

# INSTALL GIT
sudo apt-get install git -y
echo
echo "Git installed 🎉"

sudo git clone https://github.com/teziovsky/vps-setup-scripts.git /opt/vps-setup-scripts

sudo chmod -R +x /opt/vps-setup-scripts

(cd /opt/vps-setup-scripts && ./user_setup.sh)