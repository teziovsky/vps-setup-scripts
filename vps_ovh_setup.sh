#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
source vps_update_system.sh

# INSTALL GIT
source vps_install_git.sh

# SET GIT GLOBAL CONFIG


# SET NEW SSH PORT NUMBER
read -p "Enter SSH Port Number: " READ_SSH_PORT
SSH_PORT=${READ_SSH_PORT:-10022}

SSHD_FILE=/etc/ssh/sshd_config
SSHD_BACKUP_FILE=/etc/ssh/sshd_config.backup
if [ ! -f "$SSHD_BACKUP_FILE" ]; then
    sudo cp $SSHDFILE $SSHD_BACKUP_FILE
else
    echo "$SSHD_BACKUP_FILE" already exists!
fi

sed -i "s/#Port 22/Port ${SSH_PORT}/g" $SSHD_FILE
sed -i "s/PremitRootLogin yes/PremitRootLogin no/g" $SSHD_FILE
cat $SSHD_FILE
