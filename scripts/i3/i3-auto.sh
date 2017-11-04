#!/bin/bash

# Name: i3-auto
# Description: 

# xSession commands
if [ ! -z "$DISPLAY" ]
then
    # Check for previous xautolock PIDs
    if ! pgrep -u "$USER" xautolock > /dev/null
    then
        # Run xautolock with a 3 minute timeout
        nohup xautolock -time 3 -locker autolock < /dev/null > /dev/null 2>&1 &
    fi

    # TODO [170504] - Move this into the bashrc for access from tty
    # Check for previous remappings
    if xmodmap | grep -q "Caps_Lock"
    then
        # Remap <CAPS_LOCK> to <ESC>
        xmodmap ~/.config/xmodmap/.xmodmap
    fi

else # Terminal commands
    echo "term"    
fi
