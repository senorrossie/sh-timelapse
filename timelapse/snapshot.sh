#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
let HR=`date +%-H`

if [ $HR -gt 18 ] || [ $HR -lt 8 ]; then
	echo "Nighttime"
	raspistill --nopreview -r -th 0:0:0 -ex night -o /home/pi/timelapse/pictures/img_$DATE.jpg -l /home/pi/timelapse/timelapse.jpg
else
	echo "Daytime"
	raspistill --nopreview -r -th 0:0:0 -o /home/pi/timelapse/pictures/img_$DATE.jpg -l /home/pi/timelapse/timelapse.jpg
fi
