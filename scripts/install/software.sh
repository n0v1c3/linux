#!/bin/bash

# Name: software.sh
# Description: install and update software

quit=false
while ! $quit; do

  # Installed software
  pacman="$(pacman -Qqe)"

  zsh="zsh"
  case "zsh" in
    $pacman)
      echo "zsh - installed"
      ;;
    *)
      software="quit"
      ;;
  esac

  softwares="\"$zsh\"
  \"quit\""

  eval set $softwares
  select software in "$@"
  do
    # Display the selected option
    echo "$software" | awk '{print $1}'

    # Break the select loop
    if [ "$software" == "quit" ]; then
      quit=true
    else
      quit=false

      # Install and update the selected software
      #sudo pacman -Sy $software
    fi
    break
  done
done
