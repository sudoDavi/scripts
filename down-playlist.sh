#!/bin/bash
DOWNLOAD_URL="Empty URL field";
if [ -z "$1" ]; then
	#Insert the link to the playlist here
	DOWNLOAD_URL=MY_PLAYLIST
else
	DOWNLOAD_URL=$1
fi

if [ "$DOWNLOAD_URL" == "Empty URL field" ]; then
	echo "Empty URL field, Aborting.";
	exit;
fi

echo "Updating playlist local copy from URL: $DOWNLOAD_URL";
youtube-dl -i -w --yes-playlist --playlist-random --sleep-interval 10 -f 140 "$DOWNLOAD_URL"
echo "Finished updating playlist local copy";
