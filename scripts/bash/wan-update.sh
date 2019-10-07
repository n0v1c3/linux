#!/bin/bash

wan=$(curl -s ipinfo.io/ip)
export WAN=$wan
echo $(curl -s ipinfo.io/ip)
exit 0
