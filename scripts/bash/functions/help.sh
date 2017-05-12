#!/bin/bash

# Name: help.sh
# Description: Display the first block of text after the shebang

# Define default row values
row=1
row_min=3

# Loop through the first "block" of text in a file skipping the shebang
while IFS= read -r line || [ -n "$line" ] && [[ "$line" != "" ]] || [ $row -le $row_min ]; do

    # Display selected line from the "block" of text (skip shebang)
    if [ $row -ge $row_min ]; then
        echo "$line"
    fi

    # Increment row counter
    row=$[row + 1]

done < $0 # Pass current file to read
