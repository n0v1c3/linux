#!/bin/bash

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab
echo "curlftpfs#rgretchen:Cycology1@ftp.cycologybikes.ca /mnt/cycology-ftp fuse auto,user,allow_other,_netdev 0 0" >> /mnt/etc/fstab

# Set hostname
echo -n "Enter hostname: "
read hostname
echo "$hostname" > /mnt/etc/hostname
