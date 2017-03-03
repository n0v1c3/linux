echo -n "Username:"
read username

echo -n "Password:"
read -s password
echo

#cd $n0v1c3

find . -maxdepth 1 -mindepth 1 -type d -iname '*' -not -path '*/\.*' | while read dir
do
	# Update
	echo Pulling: $dir

	# Change directory and pull
	cd $dir
	git pull --prune "https://$username:$password@github.com/$username/$dir.git"

	# Return to starting directory
	cd ..
done
