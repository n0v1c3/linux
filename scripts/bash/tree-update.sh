#!/bin/bash

while true; do
	line="$(tree -d)"
	clear
	echo "$line"
	sleep 1
done
