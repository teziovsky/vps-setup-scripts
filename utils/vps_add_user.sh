#!/usr/bin/env bash
# CREATE NEW USER WITH SUDO ACCESS AND COPY OF AUTHORIZED_KEYS

# IF NO SUDO, THEN EXIT
source ./vps_check_sudo.sh

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


# stworz nowego uzytkownika
sudo useradd -m -p $(openssl passwd -1 $PASSWORD) -s /bin/bash "$USERNAME" && echo "Uzytkownik $USERNAME zostal stworzony 🎉"

# dodaj nowego uzytkownika do sudo
sudo usermod -aG sudo $USERNAME

SSH_DIR="/home/$USERNAME/.ssh"

# stworz folder na ustawienia ssh oraz ustaw odpowiednie prawa
sudo mkdir -p $SSH_DIR
sudo chmod 700 $SSH_DIR

# stworz authorized_keys oraz ustaw odpowiednie prawa
sudo touch $SSH_DIR/authorized_keys
sudo chmod 600 $SSH_DIR/authorized_keys

# zmien wlasciciela folderu i plikow
sudo chown -R $USERNAME:$USERNAME $SSH_DIR

# skopiuj klucze obecnego uzytkownika do nowo stworzoneg
cat ~/.ssh/authorized_keys 2>&1 | sudo tee -a $SSH_DIR/authorized_keys >/dev/null

echo "Pomyślnie stworzono użytkownia ${USERNAME}."