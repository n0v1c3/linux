#!/bin/bash

# Name: launcher.sh
# Description: Begin mining operation

# TODO [170825] - These variables are used accross multiple scripts
miner_user="travis"
claymore_home="/usr/local/miner"

sleep 15

# Screen logfiles will be kept in $miner_user home directory
cd "/home/$miner_user" || exit 1
rm ./last_update
rm ./screenlog.0

# Select display for proper nvidia configuration
export DISPLAY=:0
# Start xdisplay server and keep running
xinit &

sleep 15

# Set maximum wattage
sudo nvidia-smi -pl 100

# Underclock the GPU Speed
sudo nvidia-settings -a GPUGraphicsClockOffset[3]=-50

# Overclock the GPU Memory
sudo nvidia-settings -a GPUMemoryTransferRateOffset[3]=1500

# Launch miner inter detached screen
sudo su -c "screen -L -dmS ethm $claymore_home/miner.sh" || exit 1

# System recovery
sleep 10
sudo /home/$miner_user/checkup.sh

# Successful execution
exit 0
