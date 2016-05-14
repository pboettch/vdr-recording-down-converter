#!/bin/bash

#set -e

for rec in $(find $1 | grep 00001.ts$)
do
	h=`ffprobe $rec 2>&1 | grep "Video: h264"`

	if [[ "$h" =~ [0-9]{4}x[0-9]{3,4} ]]
	then
		>&2 echo "$rec is HD: ${BASH_REMATCH[0]}"
		echo $(realpath `dirname $rec`)
	else
		>&2 echo "$rec is not HD"
	fi
done


