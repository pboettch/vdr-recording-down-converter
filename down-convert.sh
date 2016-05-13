#!/bin/bash

set -ex

DIR=$1

if [ ! -d "$DIR" ]
then
	echo $DIR is not found or not a directory
	exit 1
fi

FILES=`find $DIR | grep ts$ | sort`

for FILE in $FILES
do
	sudo ffmpeg -i $FILE \
		-f mpegts \
		-vf scale=iw*.5:ih*.5 \
		-vcodec h264 \
		-qscale:v 4 \
		$FILE.mpg
	sudo mv $FILE.mpg $FILE
done

sudo vdr --genindex=$DIR
sudo chown -R vdr $DIR

