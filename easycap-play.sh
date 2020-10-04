#!/bin/bash

# Option to end the stream
if [ "$1" == "kill" ]; then
	killall -9 mplayer;
	sudo killall -9 somagic-both;
	sudo killall -9 somagic-capture;
	# Not needed because of stdout method
	#rm -f  .video .audio .video_buffer .audio_buffer;
	exit 0;
fi;

# Kill old processes
sudo killall -9 somagic-both
sudo killall -9 somagic-capture

# Check if capture card is plugged
lsusb | grep "Somagic" && PLUGGED=OK;
if [ -z $PLUGGED ]; then
	echo "Capture Card not plugged in";
	exit 1;
fi;

# Initialize the drivers
sudo somagic-init;

# Streaming

# Direct Piping method

sudo somagic-capture -n | mplayer -vf yadif,screenshot -demuxer rawvideo -rawvideo "ntsc:format=uyvy:fps=30000/1001" -aspect 4:3 -

# Removing old files
#rm -f  .video .audio .video_buffer .audio_buffer
# Making the files for stream buffering
#mkfifo .video .audio .video_buffer .audio_buffer
#sudo somagic-both -n 1>.video 2>.audio & pid=$!

# buffer the data acquired (prevent frame lost)
#buffer < .video > .video_buffer &
#buffer < .audio > .audio_buffer &

# Made so it outputs only video through stdout
#mplayer .video_buffer -vf yadif,screenshot -demuxer rawvideo -rawvideo "ntsc:format=uyvy:fps=30000/1001" -aspect 4:3 - &
# Audio disabled, handled through line in loopback
#mplayer .audio_buffer -demuxer +rawaudio -rawaudio "channels=2:samplesize=4:rate=48000"&
