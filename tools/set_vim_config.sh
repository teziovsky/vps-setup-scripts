#!/bin/bash

if ! command -v vim &> /dev/null
then
    sudo apt-get install -qq -y vim
    echo
    echo "VIM installed 🎉"
else
    echo
    echo "VIM already installed 👌🏼"
fi

# SET VIM CONFIG
VIM_CONFIG_FILE="~/.vimrc"
if [ ! -f "$VIM_CONFIG_FILE" ]; then
    wget -q -O - https://raw.githubusercontent.com/teziovsky/dotfiles/main/.vimrc > ~/.vimrc
    echo
    echo "VIM Config updated 🎉"
else
    echo
    echo "$VIM_CONFIG_FILE – already exists! 👌🏼"
fi