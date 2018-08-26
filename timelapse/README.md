# Timelapse

A series of scripts to create a timelapse video of still images.

## Crontab

Crontab file `pi.crontab` needs to be installed as the user that will run this script.
It will take a snapshot (foto) every minute and every hour it will encode the snapshots taken to a video file.

## Snapshot

The `snapshot.sh` script takes a picture and stores it into the `basedir/pictures` directory.

## Encode

`encode.sh` will encode the snapshots to an avi video file and if needed adds the newly encoded file to the end of an already created file.

`encode61N.sh` is a special case, that is used to encode a set of pictures taken using an 61N camera.