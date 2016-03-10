#!/bin/bash

# Ensure correct working directory
cd /home/rneadmin/Documents/hack

# Get IP addresses
cur_ip=$(wget http://ipinfo.io/ip -qO -)	# Current IP
old_ip=$(cat public_ip.txt)					# Previous IP

# Check current IP to previous IP
if [ "$cur_ip" != "$old_ip" ]; then					# No Match
	echo $cur_ip > public_ip.txt					# Save IP
	gpg --passphrase 1234 --yes -c public_ip.txt	# Encrypt IP
	git commit -a -m "Public IP changed"			# Commit changes
	git push										# Push changes
fi
