#!/bin/bash
# ~/VBox

# Clear terminal screen
clear

IN=$(sudo -H -u travis VBoxManage list vms)
OIFS=$IFS
IFS='"*"'
VMLIST=$IN

# Array counters
count=0

# VM arrays
VMNAMES=()
VMSTATES=()
curindex=0

for VMNAME in $VMLIST
do
	# Valid VM Name
	if [ $count -eq 1 ]; then
		VMSTATE=$(sudo -H -u travis VBoxManage showvminfo "$VMNAME" | grep "State:" | tr -d ' ')
		VMSTATES[curindex]=$VMSTATE
		VMNAMES[curindex]=$VMNAME
		echo -e "$curindex - $VMNAME - $VMSTATE"
		let curindex+=1
	fi

	# Increase Count
	let count+=1

	# Reset count
	if [ $count -eq 2 ]; then
		count=0
	fi
done

# Select VM to {start/stop}
vmindex=-1
while [ $vmindex -lt 0 ] || [ $vmindex -ge $curindex ]
do
	printf "Please enter index of VM to {start/stop}: "
	read vmindex
done

# {start/stop} selected VM based on current running status
if echo "${VMSTATES[$vmindex]}" | grep "running"; then
	sudo -H -u travis VBoxManage controlvm "${VMNAMES[$vmindex]}" savestate
else
	sudo -H -b -u travis VBoxManage startvm "${VMNAMES[$vmindex]}" --type headless
fi

# Script Complete
exit 0
