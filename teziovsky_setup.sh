#!/bin/bash

# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# UPDATE SYSTEM
sudo /bin/bash ./security/update_system.sh

# INSTALL GIT
sudo /bin/bash ./tools/install_git.sh

# INSTALL ZSH
sudo /bin/bash ./tools/install_zsh.sh

# INSTALL DOCKER
sudo /bin/bash ./install_docker.sh