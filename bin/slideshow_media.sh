#!/bin/bash

cd `dirname $0`
MEDIA=/media/
DELAY=10


wait_for_media(){
	waitmore="true"
	while [ "$waitmore" = "true" ]; do
		echo "waiting for media to be in $MEDIA"
		sleep 5
		find $MEDIA | grep -m 1 -i 'jpg' && waitmore=false
	done
}	

run_slideshow(){
	#clean up any existing
	kill $unpid

	unclutter -idle 5 &
	unpid=$!

	feh \
	--fullscreen \
	--randomize \
	--recursive \
	-D $DELAY \
	$MEDIA
}

trap cleanup INT

cleanup(){
	kill $unpid
}

## main loop ##
while true; do
	wait_for_media
	run_slideshow
done

