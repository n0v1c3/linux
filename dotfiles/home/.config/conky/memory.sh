#!/bin/bash
memory_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
memory_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
memory_total="$(echo "scale=2; $memory_total/(1024*1024)" | bc -l)"
memory_free="$(echo "scale=2; $memory_free/(1024*1024)" | bc -l)"
memory_used="$(echo "scale=2; $memory_total-$memory_free" | bc -l)"
memory_percent="$(echo "scale=2; $memory_used/$memory_total*100" | bc -l)"

swap_total=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
swap_free=$(grep SwapFree /proc/meminfo | awk '{print $2}')
swap_total="$(echo "scale=2; $swap_total/(1024*1024)" | bc -l)"
swap_free="$(echo "scale=2; $swap_free/(1024*1024)" | bc -l)"
swap_used="$(echo "scale=2; $swap_total-$swap_free" | bc -l)"
swap_percent="$(echo "scale=2; $swap_used/$swap_total*100" | bc -l)"

hd_total="$(df -h | grep /dev/sd | awk '{print $2}' | rev | cut -c 2- | rev)"
hd_used="$(df -h | grep /dev/sd | awk '{print $4}' | rev | cut -c 2- | rev)"
hd_free="$(df -h | grep /dev/sd | awk '{print $3}' | rev | cut -c 2- | rev)"
hd_percent="$((100-$(df -h | grep /dev/sd | awk '{print $5}' | rev | cut -c 2- | rev)))"

echo   "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %-15s | %-15s | %-15s |\n" 'NAME' 'USED' 'TOTAL' 'PERCENT USED'
echo   "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %15s | %15s | %15s |\n" 'RAM' "$memory_used GiB" "$memory_total GiB" "$memory_percent %"
printf "| %-10s | %15s | %15s | %15s |\n" 'SWAP' "$swap_used GiB" "$swap_total GiB" "$swap_percent %"
printf "| %-10s | %15s | %15s | %15s |\n" 'SDA' "$hd_used GiB" "$hd_total GiB" "$hd_percent %"
echo   "+------------+-----------------+-----------------+-----------------+"
