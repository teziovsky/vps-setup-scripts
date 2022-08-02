#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
source ./utils/update_system.sh

# INSTALL GIT
source ./utils/install_git.sh

# ADD USER
source ./utils/add_user.sh

# SET NEW SSH PORT
source ./utils/set_ssh_port.sh