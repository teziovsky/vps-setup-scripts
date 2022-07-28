#!/bin/bash

# IF NO SUDO, THEN EXIT
source ./utils/vps_check_sudo.sh

# UPDATE SYSTEM
source ./utils/vps_update_system.sh

# ADD USER
source ./utils/vps_add_user.sh
