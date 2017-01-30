#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

function status() {
if git diff; then
    echo "DIFF"
fi > /dev/null
}

echo $(status)

# ---
# Exit
# ---
# Successful execution
exit 0
