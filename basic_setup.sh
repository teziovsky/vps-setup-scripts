#!/bin/bash

# IF NO SUDO, THEN EXIT
sudo /bin/bash ./utils/check_sudo.sh

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"

# INSTALL GIT
sudo apt-get install git -y
echo
echo "Git installed 🎉"

sudo git clone https://github.com/teziovsky/vps-setup-scripts.git /opt/vps-setup-scripts

cd /opt/vps-setup-scripts

# ADD USER
sudo /bin/bash ./security/add_user.sh

# SET NEW SSH PORT
sudo /bin/bash ./security/set_ssh_port.sh

read -p "Please login as $USERNAME on port ${SSH_PORT}"