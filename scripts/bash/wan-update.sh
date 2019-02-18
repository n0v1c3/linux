#!/bin/bash

# Compare current WAN to previous and send update email when required
source /home/travis/.shrc
currentWAN=$(curl -s ipinfo.io/ip)

[ "$WAN" != "$currentWAN" ] && [ "$currentWAN" != "" ] && {
    sed -i "$(grep -f /home/travis/.shrc -n 'export WAN=' | cut -d : -f 1)"'s/.*/export WAN='"$currentWAN'/' ""$n0v1c3"/linux/dotfiles/home/.shrc;
    echo "<table>";
    echo "<tr>";
    echo "<td>";
    echo "Old WAN:";
    echo "</td>";
    echo "<td>";
    echo "$WAN";
    echo "</td>";
    echo "</tr>";
    echo "<tr>";
    echo "<td>";
    echo "New Wan:";
    echo "</td>";
    echo "<td>";
    echo "$currentWAN";
    echo "</td>";
    echo "</tr>";
    echo "</table>";
    source /home/travis/.shrc;
}

