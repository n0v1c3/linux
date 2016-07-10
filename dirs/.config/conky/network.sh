#!/bin/bash

# List of mapped network interfaces including the localhost loopback
interfaces="$(find . -type l -name '*' -printf '%f\n')"

# Sleep interval between update times for the linkspeed calculation
linkspeed_sleep=5

# Static headers
echo "HOSTNAME: $(hostname)"
printf "%-15s | %-15s | %-15s | %-15s | %-15s | %-15s\n" "INTERFACE" "IP ADDRESS" "SUBNET" "GATEWAY" "RX (kBps)" "TX (kBps)"

# Loop through all mapped network interfaces
for i in $interfaces
do
	# Only display "active" network interfaces
	if [ "$(cat /sys/class/net/$i/operstate)" = "up" ]
	then
		# Stamp current RX and TX information
		rx=`cat /sys/class/net/$i/statistics/rx_bytes`
		tx=`cat /sys/class/net/$i/statistics/tx_bytes`

		# Sleep interval
		sleep $linkspeed_sleep

		# New RX and TX stamp and calculation to kBps
		rx_linkspeed=$(((`cat /sys/class/net/$i/statistics/rx_bytes`-$rx)/($linkspeed_sleep*1024)))
		tx_linkspeed=$(((`cat /sys/class/net/$i/statistics/tx_bytes`-$tx)/($linkspeed_sleep*1024)))

		# Network information
		ip_addr="$(ifconfig $i | grep 'inet addr:' | cut -d : -f 2 | awk '{print $1}')"
		sub="$(ifconfig $i | grep 'inet addr:' | cut -d : -f 4 | awk '{print $1}')"
		gate="$(ip route | grep '^default' | awk -v var="/$i/" '{print $3}')"

		# Display information #echo "$i:     $ip_addr  $sub  $gate  $rx_linkspeed          $tx_linkspeed"
		printf "%-15s | %15s | %15s | %15s | %15s | %15s\n" "$i" "$ip_addr" "$sub" "$gate" "$rx_linkspeed" "$tx_linkspeed"
	fi
done
