#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./check_sudo.sh

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"
source ./utils/update_system.sh

# ADD USER
source ./utils/add_user.sh
