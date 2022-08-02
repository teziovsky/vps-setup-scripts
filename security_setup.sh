#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# ADD USER
source ./security/add_user.sh

# SET NEW SSH PORT
source ./security/set_ssh_port.sh

echo
read -p "Please login as $USERNAME on port ${SSH_PORT}"
exit