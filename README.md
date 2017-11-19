# wirelessWatchdog
Timer-based check (and reset) for headless wireless connection using networkctl on a raspi running Arch linux.

One of my headless wireless raspberry pi-s has a bad habit of dropping off the wireless network, and then never rejoining. I'm assuming it is because the wireless dongle is being powered down by mistake. This might fix the problem. If not I'll have to investigate other causes. Perhaps its power supply is inadequate and it is browning out and stalling?

## Files

File name | Purpose / functions
----------|--------------------
wlanWDog.timer|A simple timer that calls **wlanWDog.service** periodically
wlanWDog.service| `Systemd` service definition that is called by the Timer 
wlanWDprowl.sh|A `bash` shell script that restarts the network if its status is not correct

The `timer` calls the `service` every 30 minutes, and the service then runs the `shell` script.

I have found it difficult to make `systemd` services do anything more fancy than just call a script. 

If you clone this script, you will have to edit the `picdir` variable in the shell script. Note that when you run scripts from a systemd service call, you must provide absolute paths to files or directories.
