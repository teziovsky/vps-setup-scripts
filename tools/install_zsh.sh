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

# INSTALL ZSH
if ! command -v zsh &> /dev/null
then
    sudo apt-get install zsh -y
    echo
    echo "ZSH installed 🎉"
fi

# INSTALL OH-MY-ZSH
if ! command -v omz &> /dev/null
then
    sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O- | sh
    echo
    echo "oh-my-zsh installed 🎉"
fi

# INSTALL zsh-syntax-highlighting
if [ ! -d "~/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    sed -i 's|plugins=.*|plugins=(docker docker-compose sudo zsh-syntax-highlighting ufw ubuntu screen)|' ~/.zshrc
    echo
    echo "zsh-syntax-highlighting installed 🎉"
else
    echo
    echo "zsh-syntax-highlighting – already exists! 👌🏼"
fi

# SET ZSH AS DEFAULT SHELL
sudo chsh -s /bin/zsh "$USER"