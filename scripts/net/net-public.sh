#!/bin/bash

# Get script working directory
swd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get IP addresses
cur_ip=$(wget http://ipinfo.io/ip -qO -)        # Current IP
old_ip=$(cat $swd/ip.txt)			# Previous IP

# Check current IP to previous IP
if [ "$cur_ip" != "$old_ip" ]; then			# No Match
	echo $cur_ip > $swd/ip.txt		        # Save IP
	gpg --passphrase 1234 --yes -c $swd/ip.txt	# Encrypt IP
        git add $swd/ip.txt				# Add desired files to git
	git commit -m "Public IP changed"		# Commit changes
	git push					# Push changes
fi
