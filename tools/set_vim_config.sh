#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

if ! command -v vim &> /dev/null
then
    sudo apt-get install -y vim
    echo
    echo "VIM installed 🎉"
else
    echo
    echo "VIM already installed 👌🏼"
fi

# SET VIM CONFIG
VIM_CONFIG_FILE="~/.vimrc"
if [ ! -f "$VIM_CONFIG_FILE" ]; then
    sudo wget -q -O - https://raw.githubusercontent.com/teziovsky/dotfiles/main/.vimrc > ~/.vimrc
    echo
    echo "VIM Config updated 🎉"
else
    echo
    echo "'$VIM_CONFIG_FILE' – already exists! 👌🏼"
fi