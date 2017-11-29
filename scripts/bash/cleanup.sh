#!/bin/bash

# Name: cleanup.sh
# Description: 

# Remove a compiler error for an external variable
n0v1c3="$n0v1c3"

# File extensions that are allowed for clean-up
declare -a whitelist=("vim" "sh" "md")
# Directories (and subdirectories) that are dis-allowed from clean-up
declare -a blacklist=(".backup/" "" "")

# Loop through the valid files in the the whitelist
for files in "${whitelist[@]}"; do
    while read -r file; do
        echo "$file"
    done < <(find "$n0v1c3" -type f -name "*.$files")
done

# Successful execution
exit 0
