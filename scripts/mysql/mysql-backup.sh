#!/bin/bash

echo "Enter hostname/ip:"
read hostname

echo "Enter username: "
read username

echo "Enter password: "
read -s password

dateStamp="$(date +'%Y%m%d')"
backupDir="~/backups/mysql"

mkdir $backupdir/$datestamp

echo "show databases;" | mysql -h $hostname -u $username -p$password | grep ^rne_ | while read -r database
do
    echo "Processing $database"
    mysqldump --host=$hostname --user=$username --password=$password $database > "$backupDir/$datestamp/$database".db
done
