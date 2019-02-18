#!/bin/bash

# Name: miner_cron.sh
# Description: Crontask to automatically restore down workers

# Force reboot if screen is not running

if [ ! -f /home/travis/last_update ]; then
  stat -c %Y /home/travis/screenlog.0 > /home/travis/last_update
fi

if [[ $(( $(stat -c %Y /home/travis/screenlog.0) - $(cat /home/travis/last_update) )) -gt 60 ]]; then
	sudo bash -c "echo 1 > /proc/sys/kernel/sysrq"
	sudo bash -c "echo b > /proc/sysrq-trigger"
else
  # TODO-TJG [180215] - Move into crontab/service
  sleep 10
  stat -c %Y > /home/travis/last_update
	sudo /home/travis/checkup.sh &
fi

# if ! sudo su -c 'screen -list' | grep 'ethm' > /dev/null; then
	# sudo bash -c "echo 1 > /proc/sys/kernel/sysrq"
	# sudo bash -c "echo b > /proc/sysrq-trigger"
# else
	# sleep 10
	# sudo /home/travis/checkup.sh &
# fi

exit 0
