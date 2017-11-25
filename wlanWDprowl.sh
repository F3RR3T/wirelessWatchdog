#!/bin/bash
# wlanWDprowl.sh
# SJP 19 Nov 2017
#
# Designed to stop a headless wireless raspi from disappearing from the LAN.
# IS called from a systemd timer on an Arch linux OS.
#
cd /usr/local/bin
# The following block enables private configuration
# I use .gitignore to exclude the config file trom github.
logdir="/path/to/my/log"  # overwritten by sourcing from a local config file.
if [ -e wlanWDlog.conf ]; then
    . wlanWDlog.conf   # source directory name from local config file
else echo "wlanWDlog.conf does not exist"; exit 1
fi
# end of privacy config

# Get wireless adaptor name
wirelessLink=$(networkctl | awk '/wlan/ {print $2}')

# Prowl:
# Detect the state of the wireless network adaptor
wlanStatus=$(networkctl status ${wirelessLink} | awk '/State:/ {print $2}')
logline="$(date) ${wlanStatus}"
# write all to log for now. This will show if I'm still alive.
echo ${logline} >> ${logdir}/wlanStatus.log

if [ ${wlanStatus} != "routable" ]; then 
    # we have lost wireless, so log the occurrence and restart the service
    echo "lost wireless" >> ${logdir}/wlanStatus.log
    echo "Lost wireless connection. ${logline} Restarting networkd" >> ${logdir}/wlanStatus.log
    sudo systemctl restart systemd-networkd.service
fi

