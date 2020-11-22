#!/bin/bash
if [ -z $1 ]; then
	#Insert the link to the playlist here
	DOWNLOAD_URL=MY_PLAYLIST
else
	DONWLOAD_URL=$1
fi

echo "Updating playlist local copy from URL: $DOWNLOAD_URL";
youtube-dl -i -w --yes-playlist --playlist-random --sleep-interval 10 -f 140 "$DOWNLOAD_URL"
echo "Finished updating playlist local copy";
