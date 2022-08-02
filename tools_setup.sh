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
source ./tools/install_git.sh

# INSTALL ZSH
source ./tools/install_zsh.sh

# SET VIM CONFIG
source ./tools/set_vim_config.sh

# INSTALL DOCKER
source ./install_docker.sh