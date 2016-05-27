#!/bin/bash

# Install Google Authenticator
apt-get install libpam-google-authenticator

# GUI Verification
cp /etc/pam.d/lightdm /etc/pam.d/lightdm-GABackup
gui_verification="auth required pam_google_authenticator.so nullok"
count=$(cat /etc/pam.d/lightdm | grep "$gui_verification" | wc -l)
if [ $count -eq 0 ]; then
	echo "$gui_verification" >> /etc/pam.d/lightdm
fi

# TTY Verification
tty_verification="li auth required pam_google_authenticator.so nullok"
count=$(cat /etc/pam.d/common-auth | grep "$tty_verification" | wc -l)
if [ $count -eq 0 ]; then
	# Add to begining of file
	sed -i "$tty_verification" /etc/pam.d/common-auth
fi

