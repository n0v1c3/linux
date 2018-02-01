#!/bin/bash
memory_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
memory_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
memory_total="$(echo "scale=2; $memory_total/(1024*1024)" | bc -l)"
memory_free="$(echo "scale=2; $memory_free/(1024*1024)" | bc -l)"
memory_used="$(echo "scale=2; $memory_total-$memory_free" | bc -l)"
memory_percent=100
if [ $(echo "$memory_total>0" | bc) -gt 0 ]; then
  memory_percent="$(echo "scale=2; $memory_used/$memory_total*100" | bc -l)"
fi

swap_total=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
swap_free=$(grep SwapFree /proc/meminfo | awk '{print $2}')
swap_total="$(echo "scale=2; $swap_total/(1024*1024)" | bc -l)"
swap_free="$(echo "scale=2; $swap_free/(1024*1024)" | bc -l)"
swap_used="$(echo "scale=2; $swap_total-$swap_free" | bc -l)"
swap_percent=100
if [ $(echo "$swap_total>0" | bc) -gt 0 ]; then
  swap_percent="$(echo "$swap_used/$swap_total*100" | bc -l | cut -c -5)"
fi

hd_total="$(df -h | grep /dev/sd | awk '{print $2}' | rev | cut -c 2- | rev)"
hd_used="$(df -h | grep /dev/sd | awk '{print $4}' | rev | cut -c 2- | rev)"
hd_free="$(df -h | grep /dev/sd | awk '{print $3}' | rev | cut -c 2- | rev)"
hd_percent=100
if [ $(echo "$hd_total>0" | bc) -gt 0 ]; then
  hd_percent="$(echo "$hd_used/$hd_total*100" | bc -l | cut -c -5)"
fi

echo   "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %-15s | %-15s | %-15s |\n" 'NAME' 'USED' 'TOTAL' 'PERCENT USED'
echo   "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %15s | %15s | %15s |\n" 'RAM' "$memory_used GiB" "$memory_total GiB" "$memory_percent %"
printf "| %-10s | %15s | %15s | %15s |\n" 'SWAP' "$swap_used GiB" "$swap_total GiB" "$swap_percent %"
printf "| %-10s | %15s | %15s | %15s |\n" 'SDA' "$hd_used GiB" "$hd_total GiB" "$hd_percent %"
echo   "+------------+-----------------+-----------------+-----------------+"
