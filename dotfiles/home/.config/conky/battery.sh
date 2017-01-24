#!/bin/bash

cpu_count=$(cat /proc/cpuinfo | grep processor | wc -l)
table_width=340
graph_offset=25
column_25=155

echo "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %-15s | %-15s | %-15s |\n" "CPU" "BAR GRAPH" "USAGE (%)" "T"
echo "+------------+-----------------+-----------------+-----------------+"
for i in `seq 0  $(( $cpu_count-1 ))`
do
	printf "| %-10s | %-15s | %-15s | %15s |\n" "cpu$i" "\${cpu cpu$i} %\${goto $column_25}" "\${cpubar cpu$i 10,90}" "\${cpugraph cpu$i 10,90}"
done
echo "+------------+-----------------+-----------------+-----------------+"
echo "| \${cpugraph 11,$(( $table_width-$graph_offset ))}\${goto $table_width}|"
echo "+------------+-----------------+-----------------+-----------------+"
