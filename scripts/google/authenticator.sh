#!/bin/bash

# Install Google Authenticator
apt-get install libpam-google-authenticator

# Backup
cp /etc/pam.d/lightdm /etc/pam.d/lightdm-GABackup
cp /etc/pam.d/common-auth /etc/pam.d/common-auth-GABackup

# GUI Verification
echo "auth required pam_google_authenticator.so nullok" >> /etc/pam.d/lightdm

# TTY Verification
sed -i "1i auth required pam_google_authenticator.so nullok" /etc/pamd.d/common-auth
