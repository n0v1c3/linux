echo -n "Username:"
read username
echo

echo -n "Password:"
read -s password
echo

find . -maxdepth 1 -mindepth 1 -type d -iname '*' | while read dir
do
	# Update
	echo Pulling: $dir

	# Change directory and pull
	cd $dir
	git pull --prune

	# Return to starting directory
	cd ..
done
