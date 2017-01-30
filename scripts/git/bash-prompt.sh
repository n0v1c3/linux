#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

function status() {
if git diff-index --quiet HEAD --; then
    # No changes
    echo "NO DIFF"
else
    # Changes
    echo "DIFF"
fi
}

echo $(status)

# ---
# Exit
# ---
# Successful execution
exit 0
