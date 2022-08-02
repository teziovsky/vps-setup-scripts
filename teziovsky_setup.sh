#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
source ./security/update_system.sh

# INSTALL GIT
source ./utils/install_git.sh

# INSTALL ZSH
source ./utils/install_zsh.sh

# INSTALL DOCKER
source ./