#!/bin/bash

if [ "`grep 61N /proc/mounts`" == "" ]; then
	echo "61N Camera not mounted!"
	exit 1
fi

DATE=$(date +"%Y-%m-%d_%H%M")
BASEDIR=/mnt/61N/
OUTDIR=/home/pi/timelapse

if [ -d ${BASEDIR} ]; then
	ls -1 ${BASEDIR}/*.jpg > ${OUTDIR}/timelapse61N.pls

	mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 \
	 -vf scale=1920:1080 -o ${OUTDIR}/timelapse61N-$DATE.avi \
	 -mf type=jpeg:fps=24 mf://@${OUTDIR}/timelapse61N.pls

	for IMG in $( cat ${OUTDIR}/timelapse61N.pls ); do sudo rm -f $IMG ; done
fi

# Concatenate videos
### Rename current (From basedir)
cd ${OUTDIR}
mv timelapse61N.avi timelapse61N-1970-01-01_0000.avi
if [ $? ]; then
	echo "file 'timelapse61N-1970-01-01_0000.avi'" > videos61N.pls
	echo "file 'timelapse61N-$DATE.avi'" >> videos61N.pls
	ffmpeg -f concat -i videos61N.pls -c copy timelapse61N.avi
	rm timelapse61N-1970-01-01_0000.avi timelapse61N-$DATE.avi
else
	echo "***ERROR*** Unable to concatenate AVI files."
fi
echo "Don't forget to unmount the 61N Camera"
