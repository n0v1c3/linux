#!/bin/bash

# Name: miner.sh
# Description: Select wallet and launch mining software using computer hostname as rig name

claymore_home="/usr/local/miner"

active_wallet=1
wallets[1]="bb79025cad54f79c7ec7f875e0bf4da428fce3ac" # travis
wallets[2]="188e78743b179098f85653374a9bfb4778990673" # kristina

export GPU_MAX_ALLOC_PERCENT=100

LD_PRELOAD=/usr/lib/libcurl.so.3 "$claymore_home/ethdcrminer64" -epool us1.ethermine.org:4444 -ewal "${wallets[$active_wallet]}"."$(hostname)" -epsw x -mode 1 -tt 0 -allpools 1

# Successful execution
exit 0
