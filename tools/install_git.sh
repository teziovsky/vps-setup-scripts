#!/bin/bash

# IF NO SUDO, THEN EXIT
sudo /bin/bash ../utils/check_sudo.sh

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
