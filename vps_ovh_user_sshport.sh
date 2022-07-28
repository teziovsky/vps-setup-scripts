#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
source ./utils/vps_update_system.sh

# SET NEW SSH PORT NUMBER
source ./utils/vps_set_ssh_port.sh

# ADD USER
source ./utils/vps_add_user.sh

