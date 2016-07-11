#!/bin/bash

users="$(users | uniq | sort)"
echo "+------------+-----------------+"
printf "| %-10s | %15s |\n" "USERS" "USERS"
echo "\${scroll 15 3 $users}"
echo "\${color red}+------------+-----------------+\${color}"
