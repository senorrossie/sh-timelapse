# Timelapse

A series of scripts to create a timelapse video of still images.

## Crontab

The previous method used cron. With the need to take a snapshot more than once per minute, cron is out of the question. Run the snapshot script from rc.local or something similar and run the encode.sh script from /etc/cron.hourly by creating a symlink there (sudo or as root user): `ln -s /home/pi/timelapse/encode.sh /etc/cron.hourly/timelapse_encode`

## Snapshot

The `snapshot.sh` script takes a picture and stores it into the `basedir/pictures` directory.

## Encode

`encode.sh` will encode the snapshots to an avi video file and if needed adds the newly encoded file to the end of an already created file.

`encode61N.sh` is a special case, that is used to encode a set of pictures taken using an 61N camera.