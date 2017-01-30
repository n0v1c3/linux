#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

function status() {
if git diff > /dev/null; then
    echo "DIFF"
fi
}

echo $(status)

# ---
# Exit
# ---
# Successful execution
exit 0
