# SET NEW SSH PORT NUMBER
echo
read -p "Enter SSH Port Number: " READ_SSH_PORT
SSH_PORT=${READ_SSH_PORT:-10022}

SSHD_FILE="/etc/ssh/sshd_config"
SSHD_BACKUP_FILE="/etc/ssh/sshd_config.backup"
if [ ! -f "$SSHD_BACKUP_FILE" ]; then
    sudo cp $SSHD_FILE $SSHD_BACKUP_FILE
else
    echo "$SSHD_BACKUP_FILE" – Backup already exists!
fi

if grep -q "#Port 22" "$SSHD_FILE"; then
    sudo sed -i "s/#Port 22/Port ${SSH_PORT}/g" $SSHD_FILE
else
    sudo echo "Port ${SSH_PORT}" >> $SSHD_FILE
fi

if grep -q "PremitRootLogin yes" "$SSHD_FILE"; then
    sudo sed -i "s/PremitRootLogin yes/PremitRootLogin no/g" $SSHD_FILE
else
    sudo echo "PremitRootLogin no" >> $SSHD_FILE
fi

cat $SSHD_FILE

sudo systemctl restart sshd
