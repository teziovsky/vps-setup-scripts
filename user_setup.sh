#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./utils/check_sudo.sh

# UPDATE SYSTEM
source ./utils/update_system.sh

# INSTALL GIT
source ./utils/install_git.sh

# ADD USER
source ./utils/add_user.sh

# SET NEW SSH PORT
source ./utils/set_ssh_port.sh