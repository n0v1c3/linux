#!/bin/sh

# Name: ssh-key_copy.sh
# Description: Copy user's public RSA key onto a remote computer

echo -n "Enter username: "
read username
echo ""

echo -n "Enter destination: "
read destination
echo ""

ssh $username@$destination 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
