#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./utils/vps_check_sudo.sh

# UPDATE SYSTEM
source ./utils/vps_update_system.sh

# SET NEW SSH PORT NUMBER
source ./utils/vps_set_ssh_port.sh

# ADD USER
source ./utils/vps_add_user.sh

