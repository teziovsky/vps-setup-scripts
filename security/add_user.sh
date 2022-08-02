#!/bin/bash
# AUTHORS: Radoslaw Karasinski, Grzegorz Ćwikliński, Szymon Hryszko, Artur Stefański
# MODIFIED BY: Jakub Soboczyński

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

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
        echo
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

read -p "Podaj nazwę użytkownika: " USERNAME
USERNAME_ARG=0

checkIfUserBlank $USERNAME
checkIfUserExists $USERNAME
passwordGet $USERNAME_ARG


# CREATE NEW USER
sudo useradd -m -p $(openssl passwd -1 $PASSWORD) -s /bin/bash "$USERNAME"

# ADD NEW USER TO SUDO
sudo usermod -aG sudo $USERNAME

SSH_DIR="/home/$USERNAME/.ssh"
echo "${USERNAME}"
echo "${SSH_DIR}"
# CREATE DIRECTORY FOR SSH AND SET PERMISSIONS
sudo mkdir -p $SSH_DIR
sudo chmod 700 $SSH_DIR

# COPY authorized_keys FROM EXISTING USER
sudo cp ~/.ssh/authorized_keys $SSH_DIR/authorized_keys

# CHANGE OWNER OF DIRECTORY AND FILES
sudo chown -R $USERNAME:$USERNAME $SSH_DIR
sudo chmod 600 $SSH_DIR/authorized_keys

echo
echo "Pomyślnie stworzono użytkownia ${USERNAME} 🎉"
