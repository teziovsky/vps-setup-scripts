#!/bin/bash

# IF NO SUDO, THEN EXIT
sudo /bin/bash ../utils/check_sudo.sh

# UPDATE SYSTEM
sudo apt-get update -y && sudo apt-get upgrade -y
echo
echo "System updated! 🎉"