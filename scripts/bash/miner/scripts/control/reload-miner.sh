#!/bin/sh

# Name: reload-miners.sh
# Description: Shutdown and reload the mining software

# ssh -t -p 4445 72.2.38.170 "ssh -t -p 2222 localhost 'pkill screen; shutdown -c; /home/travis/miner_launcher.sh'"
ssh -t -p 4445 72.2.38.170 'pkill screen; shutdown -c; /home/travis/miner_launcher.sh'
