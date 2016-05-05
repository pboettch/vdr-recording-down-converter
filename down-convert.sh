#!/bin/bash

DIR=$1

if [ ! -d "$DIR" ]
then
	echo $DIR is not found or not a directory
	exit 1
fi

FILES=`find $DIR | grep ts$ | sort`

for FILE in $FILES
do
	echo sudo ffmpeg -i $FILE \
		-f mpegts \
		-vf scale=iw*.5:ih*.5 \
		-acodec copy \
		-vcodec mpeg2video \
		-qscale:v 5 \
		$FILE.mpg
	echo sudo mv $FILE.mpg $FILE
done

echo sudo vdr --genindex=$DIR
echo sudo chown -R vdr $DIR

