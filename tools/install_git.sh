#!/bin/bash

# INSTALL GIT
if ! command -v git &> /dev/null
then
    sudo apt-get install -qq git -y
    echo
    echo "Git installed 🎉"
fi

# SET GITCONFIG
GITCONFIG_FILE="~/.gitconfig"
if [ ! -f "$GITCONFIG_FILE" ]; then
    wget -q -O - https://raw.githubusercontent.com/teziovsky/dotfiles/main/.gitconfig > ~/.gitconfig
    echo
    echo "Git installed 🎉"
else
    echo
    echo ".gitconfig already exists! 👌"
fi
