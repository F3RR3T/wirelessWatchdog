#!/bin/bash
# wlanWDprowl.sh
# SJP 19 Nov 2017
#
# Designed to stop a headless wireless raspi from disappearing from the LAN.
# IS called from a systemd timer
#
cd /usr/local/bin
# The following block enables private configuration
logdir="/path/to/my/log"  # overwritten by sourcing from .logdir.config
if [ -e logdir.config ]; then
        . logdir.config   # source directory name from local config file
else echo "logdir.config does not exist"; exit 1
fi
# end of privacy config

# Detect the state of the wireless network adaptor
wirelessLink='wlan0'    # ymmv
networkctl status ${wirlesessLink} | grep 'State:'


