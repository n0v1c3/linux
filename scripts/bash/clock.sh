#!/bin/bash

# Return the desired column to start text output on right side
function position_cursor {

# Current width of terminal
cols=$(tput cols)

# Current height of terminal
rows=$(tput lines)

# Return number of columns with offset for clock
echo $(($cols - 4))
}

# Output clock in top right of terminal
function clock
{

	# Save current cursor position
	echo -en "\033[s"

	# Position cursor at top right of terminal
	echo -en "\033[0;$(position_cursor)H"

	# Echo 24 hour clock
	echo -en $(date +"%H:%M")

	# Restore saved cursor position
	echo -en "\033[u"
}

# Running loop
while true; do

	# Output clock in top right of terminal
	clock

	# Sleep
	sleep 1
done
