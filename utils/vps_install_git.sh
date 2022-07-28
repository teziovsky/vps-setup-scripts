#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./vps_check_sudo.sh

# INSTALL GIT
sudo apt-get install git -y
echo
echo "Git installed 🎉"