#!/bin/sh

remote_file="http://PATH/TO/FILE/ONLINE"
local_file="LOCAL/PATH/TO/FILE"

ping -q -c1 DOMAIN/OF/ONLINE/FILE > /dev/null

if [ $? -eq 0 ]
then
	echo "Internet is connected"
	cd FOLDER/OF/LOCAL/FILE
	md5_old=$( md5sum $local_file 2>/dev/null )
	wget -N $remote_file
	md5_new=$( md5sum $local_file )

	if [ "$md5_old" != "$md5_new" ]; then
		echo "Latest version has been downloaded"
		wget -O $local_file $remote_file
		chmod +x $local_file
	else
		echo "Already have latest version"
	fi
else
	echo "Internet is not connected - not checking for newer version"
fi
