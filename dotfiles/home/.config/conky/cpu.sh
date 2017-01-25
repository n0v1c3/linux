#!/bin/bash

cpu_count=$(cat /proc/cpuinfo | grep processor | wc -l)
table_width=340
graph_offset=20
column_25=155

echo "+------------+-----------------+-----------------+-----------------+"
printf "| %-10s | %-15s | %-15s | %-15s |\n" "CPU" "BAR GRAPH" "USAGE (%)" "T"
echo "+------------+-----------------+-----------------+-----------------+"
for i in `seq 1  $(( $cpu_count ))`
do
	printf "| %-10s | %-15s | %-15s | %15s |\n" "cpu$i" "\${cpu cpu$i} %\${goto $column_25}" "\${cpubar cpu$i 10,75}" "\${cpugraph cpu$i 10,75}"
done
echo "+------------+-----------------+-----------------+-----------------+"
echo "|\${goto $table_width}|"
echo "|\${goto $table_width}|"
echo "\${goto 14}\${voffset -20}\${cpugraph 15,$(( $table_width-$graph_offset ))}\${goto $table_width}\${voffset -4}"
echo "+------------+-----------------+-----------------+-----------------+"
