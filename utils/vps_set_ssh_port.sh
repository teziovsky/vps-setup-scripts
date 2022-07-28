#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./vps_check_sudo.sh

# SET NEW SSH PORT NUMBER
echo
read -p "Enter SSH Port Number: " READ_SSH_PORT
SSH_PORT=${READ_SSH_PORT:-10022}

SSHD_FILE="/etc/ssh/sshd_config"
SSHD_BACKUP_FILE="/etc/ssh/sshd_config.backup"
if [ ! -f "$SSHD_BACKUP_FILE" ]; then
    sudo cp $SSHD_FILE $SSHD_BACKUP_FILE
else
    echo "'$SSHD_BACKUP_FILE' – Backup already exists! 👌"
fi

if grep -q "#Port 22" "$SSHD_FILE"; then
    sudo sed -i "s/#Port 22/Port ${SSH_PORT}/g" $SSHD_FILE

    elif grep -q "Port ${SSH_PORT}" "$SSHD_FILE"; then
    echo "Port already set 👌"
else
    echo "Port ${SSH_PORT}" | sudo tee -a $SSHD_FILE
fi

if grep -q "PermitRootLogin yes" "$SSHD_FILE"; then
    sudo sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" $SSHD_FILE

    elif grep -q "PermitRootLogin no" "$SSHD_FILE"; then
    echo "PermitRootLogin already set 👌"
else
    echo "PermitRootLogin no" | sudo tee -a $SSHD_FILE
fi

cat $SSHD_FILE

sudo systemctl restart sshd
