#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
BASEDIR=/home/pi/timelapse/

if [ -d ${BASEDIR} ]; then
	ls -1 ${BASEDIR}/pictures/*.jpg > ${BASEDIR}/timelapse.pls

	mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 \
	 -vf scale=1920:1080 -o ${BASEDIR}/timelapse-$DATE.avi \
	 -mf type=jpeg:fps=24 mf://@${BASEDIR}/timelapse.pls

	for IMG in $( cat ${BASEDIR}/timelapse.pls ); do rm -f $IMG ; done
fi

# Concatenate videos
### Rename current (From basedir)
cd ${BASEDIR}
mv timelapse.avi timelapse-1970-01-01_0000.avi
if [ $? ]; then
	echo "file 'timelapse-1970-01-01_0000.avi'" > ${BASEDIR}/videos.pls
	echo "file 'timelapse-$DATE.avi'" >> ${BASEDIR}/videos.pls
	ffmpeg -f concat -i videos.pls -c copy timelapse.avi
	rm timelapse-1970-01-01_0000.avi timelapse-$DATE.avi
else
	echo "***ERROR*** Unable to concatenate AVI files."
fi
