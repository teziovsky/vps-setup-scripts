#!/bin/bash
# AUTHORS: Radoslaw Karasinski, Grzegorz Ćwikliński, Szymon Hryszko, Artur Stefański
# MODIFIED BY: Jakub Soboczyński

# IF NO SUDO, THEN EXIT
source ./check_sudo.sh

checkIfUserExists() {
    GIVEN_USER=$1
    if sudo id "${GIVEN_USER}" &>/dev/null; then
        echo "Użytkownik ${GIVEN_USER} już istnieje!"
        exit 1
    fi
}

checkIfUserBlank() {
    GIVEN_USER=$1
    if [ -z "$1" ]; then
        echo "Nie podałeś nazwy użytkownika!"
        exit 1
    fi
}

passwordGet(){
    USERNAME_ARG=$1
    while true; do
        if [ "$USERNAME_ARG" -eq "0" ]; then
            read -s -p "Podaj hasło (zostaw puste aby wygenerować): " PASSWORD
            echo
        fi
        
        # CHECK IF PASSWORD IS BLANK
        if [ -z "$PASSWORD" ]; then
            # GENERATE PASSWORD
            PASSWORD=$(head -c255 /dev/urandom | base64 | grep -Eoi '[a-z0-9]{12}' | head -n1)
            echo "Twoje hasło to $PASSWORD"
            break
        fi
        
        read -sp 'Powtórz hasło: ' PASSWORD_REPEAT
        echo
        
        # if passwords are equal
        if [ "$PASSWORD" == "$PASSWORD_REPEAT" ]; then
            break
        else
            echo "Hasła się nie zgadzają, spróbuj ponownie!"
        fi
    done
}

if ! [ -z "$1" ]; then
    USERNAME=$1
    USERNAME_ARG=1
else
    read -p "Podaj nazwę użytkownika: " USERNAME
    USERNAME_ARG=0
fi

checkIfUserBlank $USERNAME
checkIfUserExists $USERNAME
passwordGet $USERNAME_ARG


# CREATE NEW USER
sudo useradd -m -p $(openssl passwd -1 $PASSWORD) -s /bin/bash "$USERNAME"

# ADD NEW USER TO SUDO
sudo usermod -aG sudo $USERNAME

SSH_DIR="/home/$USERNAME/.ssh"

# CREATE DIRECTORY FOR SSH AND SET PERMISSIONS
sudo mkdir -p $SSH_DIR
sudo chmod 700 $SSH_DIR

# CREATE authorized_keys AND SET PERMISSIONS
sudo touch $SSH_DIR/authorized_keys
sudo chmod 600 $SSH_DIR/authorized_keys

# CHANGE OWNER OF DIRECTORY AND FILES
sudo chown -R $USERNAME:$USERNAME $SSH_DIR

# COPY KEYS FROM ACTUAL USER TO NEW USER
cat ~/.ssh/authorized_keys 2>&1 | sudo tee -a $SSH_DIR/authorized_keys >/dev/null

echo "Pomyślnie stworzono użytkownia ${USERNAME} 🎉"ORT NUMBER
echo
read -p "Enter SSH Port Number: " READ_SSH_PORT
SSH_PORT=${READ_SSH_PORT:-10022}

SSHD_FILE="/etc/ssh/sshd_config"
SSHD_BACKUP_FILE="/etc/ssh/sshd_config.backup"
if [ ! -f "$SSHD_BACKUP_FILE" ]; then
    sudo cp $SSHD_FILE $SSHD_BACKUP_FILE
else
    echo
    echo "'$SSHD_BACKUP_FILE' – Backup already exists! 👌"
fi

if grep -q "#Port 22" "$SSHD_FILE"; then
    sudo sed -i "s/#Port 22/Port ${SSH_PORT}/g" $SSHD_FILE

    elif grep -q "Port ${SSH_PORT}" "$SSHD_FILE"; then
    echo
    echo "Port already set 👌"
else
    echo
    echo "Port ${SSH_PORT}" | sudo tee -a $SSHD_FILE
fi

if grep -q "PermitRootLogin yes" "$SSHD_FILE"; then
    sudo sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" $SSHD_FILE

    elif grep -q "PermitRootLogin no" "$SSHD_FILE"; then
    echo
    echo "PermitRootLogin already set 👌"
else
    echo
    echo "PermitRootLogin no" | sudo tee -a $SSHD_FILE
fi

if grep -q "PasswordAuthentication yes" "$SSHD_FILE"; then
    sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" $SSHD_FILE

    elif grep -q "PasswordAuthentication no" "$SSHD_FILE"; then
    echo
    echo "PasswordAuthentication already set 👌"
else
    echo
    echo "PasswordAuthentication no" | sudo tee -a $SSHD_FILE
fi

sudo systemctl restart sshd
echo
echo "SSH Port changed to ${SSH_PORT} 🎉"