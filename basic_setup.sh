#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"

# INSTALL GIT
sudo apt-get install git -y
echo
echo "Git installed 🎉"

sudo git clone https://github.com/teziovsky/vps-setup-scripts.git /opt/vps-setup-scripts

# ADD USER
(cd /opt/vps-setup-scripts && sudo /bin/bash ./security/add_user.sh)

# SET NEW SSH PORT
(cd /opt/vps-setup-scripts && sudo /bin/bash ./security/set_ssh_port.sh)

read -n 1 -p "Please login as $USERNAME on port ${SSH_PORT}"