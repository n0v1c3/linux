# Kill existing and restart xautolock using custom autolock
killall xautolock
xautolock -time 3 -locker autolock > /dev/null &
