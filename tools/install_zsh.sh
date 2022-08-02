#!/bin/bash

# INSTALL GIT
if ! command -v git &> /dev/null
then
    sudo apt-get install -qq git -y
    echo
    echo "Git installed 🎉"
fi

# INSTALL ZSH
if ! command -v zsh &> /dev/null
then
    sudo apt-get install -qq zsh -y
    echo
    echo "ZSH installed 🎉"
fi

# INSTALL OH-MY-ZSH
if ! command -v omz &> /dev/null
then
    wget -q https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O- | sh
    ZSH_THEME="alanpeabody"
    sudo sed -i "s/ZSH_THEME="robbyrussell"/ZSH_THEME="alanpeabody"/g" ~/.zshrc
    echo
    echo "oh-my-zsh installed 🎉"
else
    echo
    echo "oh-my-zsh already installed 👌"
fi

# INSTALL zsh-syntax-highlighting
if [ ! -d "~/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    git clone -q https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    sed -i 's|plugins=.*|plugins=(docker docker-compose sudo zsh-syntax-highlighting zsh-autosuggestions ufw ubuntu screen)|' ~/.zshrc
    echo
    echo "zsh-syntax-highlighting installed 🎉"
else
    echo
    echo "zsh-syntax-highlighting – already exists! 👌🏼"
fi

# SET ZSH AS DEFAULT SHELL
sudo chsh -s /bin/zsh "$USER"