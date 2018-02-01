#!/bin/bash

# Network interfaces directory
interfaces_dir="/sys/class/net/"

# List of mapped network interfaces including the localhost loopback
interfaces="$(find $interfaces_dir -type l -name '*' -printf '%f\n')"

# Sleep interval between update times for the linkspeed calculation
linkspeed_sleep=1

# Static headers
echo   "+------------+-----------------+"
printf "| %-10s | %15s |\n" "HOSTNAME" "$(hostname)"
echo   "+------------+-----------------+"
echo   "+------------+-----------------+-----------------+-----------------+------------+------------+"
printf "| %-10s | %-15s | %-15s | %-15s | %-10s | %-10s |\n" "INTERFACE" "IP ADDRESS" "SUBNET" "GATEWAY" "RX (kBps)" "TX (kBps)"
echo   "+------------+-----------------+-----------------+-----------------+------------+------------+"

# Loop through all mapped network interfaces
for i in $interfaces
do
	# Only display "active" network interfaces
	if [ "$(cat $interfaces_dir$i/operstate)" = "up" ]
	then
		# Stamp current RX and TX information
		rx=`cat $interfaces_dir$i/statistics/rx_bytes`
		tx=`cat $interfaces_dir$i/statistics/tx_bytes`

		# Sleep interval
		sleep $linkspeed_sleep

		# New RX and TX stamp and calculation to kBps
		rx_linkspeed=$(((`cat $interfaces_dir$i/statistics/rx_bytes`-$rx)/($linkspeed_sleep*1024)))
		tx_linkspeed=$(((`cat $interfaces_dir$i/statistics/tx_bytes`-$tx)/($linkspeed_sleep*1024)))

		# Network information
		ip_addr="$(ip addr show $i | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1 )"
		sub="$(ip addr show $i | grep 'inet\b' | awk '{print $4}' )"
		gate="$(ip route | grep '^default' | awk -v var="/$i/" '{print $3}')"

		# Display information #echo "$i:     $ip_addr  $sub  $gate  $rx_linkspeed          $tx_linkspeed"
		printf "| %-10s | %15s | %15s | %15s | %10s | %10s |\n" "$i" "$ip_addr" "$sub" "$gate" "$rx_linkspeed" "$tx_linkspeed"
	fi
done

echo   "+------------+-----------------+-----------------+-----------------+------------+------------+"
