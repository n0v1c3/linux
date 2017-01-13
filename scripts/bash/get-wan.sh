currentWAN=$(curl ipinfo.io/ip)
previousWAN=$(cat ~/Documents/temp/wan)

echo $previousWAN
echo $currentWAN
#echo [[ $previousWAN != $currentWAN ]]
if [ "$previousWAN" != "$currentWAN" ]
then
    echo "Updating WAN IP Address and sending E-Mail"
    echo $currentWAN > ~/Documents/temp/wan
    echo $currentWAN | mail -s "House WAN" travis.gall@gmail.com
fi
