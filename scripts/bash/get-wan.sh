#!/bin/bash

# Compare current WAN to previous and send update email when required
source /home/travis/.shrc
currentWAN=$(curl -s ipinfo.io/ip)
[ "$WAN" != "$currentWAN" ] && { sed -i $(cat /home/travis/.shrc | grep -n 'export WAN=' | cut -d : -f 1)'s/.*/export WAN='$currentWAN'/' /home/travis/.shrc; echo $currentWAN; }

