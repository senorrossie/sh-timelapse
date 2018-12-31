#!/bin/bash
#----------
# Take snapshot every $SLEEP seconds. Can not be run from cron anymore

### Settings
OUTDIR=/home/pi/timelapse/pictures/
WEBDIR=/home/pi/timelapse/
PARAM="--nopreview -r -th 0:0:0"
SLEEP=10

function do_Snapshot() {
	raspistill ${SPARAM} \
		-o ${OUTDIR}/img_$DATE.jpg \
		-l ${WEBDIR}/timelapse.jpg
}

if [ ! -d "$OUTDIR" ] && [ -z "$OUTDIR" ]; then
	mkdir -p $OUTDIR
fi
if [ ! -d "$WEBDIR" ] && [ -z "$WEBDIR" ]; then
	mkdir -p $WEBDIR
fi

### Main
while [ true ]; do
	DATE=$(date +"%Y-%m-%d_%H%M%S")
	let HR=`date +%-H`

  # Replace by something that parses https://sunrise-sunset.org/api
	if [ $HR -gt 18 ] || [ $HR -lt 8 ]; then
		echo "Nighttime"
		SPARAM="${PARAM} -ex night"
	fi
	do_Snapshot

	sleep ${SLEEP}
done
