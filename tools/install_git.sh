#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# INSTALL GIT
if ! command -v git &> /dev/null
then
    sudo apt-get install git -y
    echo
    echo "Git installed 🎉"
fi

# SET GITCONFIG
GITCONFIG_FILE="~/.gitconfig"
if [ ! -f "$GITCONFIG_FILE" ]; then
    sudo wget -q -O - https://raw.githubusercontent.com/teziovsky/dotfiles/main/.gitconfig > ~/.gitconfig
else
    echo
    echo ".gitconfig already exists! 👌"
fi
