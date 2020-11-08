#!/bin/bash

youtube-dl -i --yes-playlist --playlist-random --sleep-interval 10 -f 140 "$1"
