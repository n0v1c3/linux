#!/bin/bash

#===================================================================================================
# a simple dmenu session script 
#===================================================================================================
DMENU='dmenu -i -nb #14151f -nf #999999 -sb #000000 -sf #31658C'

choice=$(
echo "android-studio
arandr
baobab
clementine
conky
deluge
firefox
geany
gedit
gource
hibernate
kodi
libreoffice
logout
reboot
remmina
retext
shutdown
software-center
suspend
teamviewer
thunar
urxvt
virtualbox
vlc" | $DMENU
)

case "$choice" in
    android-studio)
        bash /opt/android-studio/bin/studio.sh
        ;;
    arandr)
        arandr &
        ;;
    baobab)
        baobab &
        ;;
    clementine)
        clementine &
        ;;
    conky)
        conky &
        ;;
    deluge)
        deluge &
        ;;
    firefox)
        firefox &
        ;;
    geany)
        geany &
        ;;
    gedit)
        gedit &
        ;;
    hibernate)
        pm-hibernate &
        ;;
    kodi)
        kodi &
        ;;
    libreoffice)
        libreoffice &
        ;;
    logout)
        i3-msg exit &
        ;;
    reboot)
        shutdown -r now &
        ;;
    retext)
        retext &
        ;;
    remmina)
        remmina &
        ;;
    shutdown)
        shutdown -h now &
        ;;
    software-center)
        software-center &
        ;;
    suspend)
        sudo pm-suspend &
        ;;
    teamviewer)
        teamviewer &
        ;;
    thunar)
        thunar &
        ;;
    urxvt)
        urxvt &
        ;;
    virtualbox)
        virtualbox &
        ;;
    vlc)
        vlc &
        ;;
esac
