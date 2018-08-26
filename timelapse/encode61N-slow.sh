ffmpeg -framerate 10 -i %03d.jpg -c:v libx264 -s:v 1920:1080 -r 30 ../timelapse61N-slow.mp4 
