#!/bin/bash

# IF NO SUDO, THEN EXIT
sudo /bin/bash ./utils/check_sudo.sh

# UPDATE SYSTEM
sudo /bin/bash ./security/update_system.sh

# INSTALL GIT
sudo /bin/bash ./tools/install_git.sh

# INSTALL ZSH
sudo /bin/bash ./tools/install_zsh.sh

# INSTALL DOCKER
sudo /bin/bash ./install_docker.sh