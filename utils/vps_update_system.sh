#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./vps_check_sudo.sh

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"