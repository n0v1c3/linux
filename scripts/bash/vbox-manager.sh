#!/bin/bash
# ~/VBox

# Used to mount an encrypted file system from the admin
# mountCount=$(mount | grep -c /home/rneadmin/vBox)
# if [ $mountCount -ge 1 ] ; then
	# echo "vBox Mounted!"
# else
	# echo "Mounting vBox!"	
	# sudo mount -t ecryptfs /home/rneadmin/vBox /home/rneadmin/vBox > /dev/null
# fi

IN=$(sudo -H -u travis VBoxManage list vms)
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
	read -r vmindex
done
echo

# {start/stop} selected VM based on current running status
if echo "${VMSTATES[$vmindex]}" | grep "running"; then
	sudo -H -u travis VBoxManage controlvm "${VMNAMES[$vmindex]}" savestate
else
	sudo -H -b -u travis VBoxManage startvm "${VMNAMES[$vmindex]}" --type headless
fi

# Wrap up
echo
sleep 2s
echo "Press [Any Key] to continue..."
read -r -n 1

# Script complete
exit 0
