#!/bin/sh
for i in $(seq 254);
do
  for j in $(seq 254);
  do
    ping -i 0.2 -c 1 192.168.$i.$j | grep 'from' &
  done
done
