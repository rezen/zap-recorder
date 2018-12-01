#!/bin/sh

HERE="$PWD"
export DISPLAY=:1.0
export XKL_XMODMAP_DISABLE=1

if [ ! -f /tmp/.X1-lock ]
then
  # @todo make screen size configureable
  Xvfb :1 -ac -screen 0 1440x900x24  +extension RANDR &
fi

mkdir -p /usr/share/unity/indicators

# Start window manager
# @todo log to specific file
gnome-session &
gnome-panel &
metacity &
sleep 1
xhost +
sleep 1

# @todo adjust logging
su - zap -c "/zap/zap.sh -addonupdate -config start.installAddonUpdates=true -config quickstart.launch.defaultBrowser=Firefox -config start.checkForUpdates=true -config database.newsessionprompt=false -config view.uiWmHandling=1 -config start.checkAddonUpdates=true &"

# Wait for ZAP to load
sleep 6
sh -c 'tail -f /home/zap/.ZAP_D/zap.log  | { grep -m 1 "New Session" && echo ZAP_READY &&  kill $$ ;}'

# Make ZAP full screen
wmctrl -ir $(wmctrl -l | grep ZAP | cut -d' ' -f1)  -b add,maximized_vert,maximized_horz
sleep 1

# Start recording
ffmpeg -y -probesize 20M -r 30 -s 1440x900 -f x11grab -i :1 -g 600 -vcodec libx264 output/clip.mp4 &
VID=$!

# Start GUI interactions
sleep 1
python gui.py
sleep 1

# Kill recording
# @todo while loop until ffmpeg dies
kill -INT $VID
sleep 5

# Convert video to gif
# https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
# https://medium.com/@colten_jackson/doing-the-gif-thing-on-debian-82b9760a8483
# -ss=seek, -t=duration
ffmpeg -vsync 0 -t 1.3 -i output/clip.mp4 -vf fps=15,scale=320:-1:flags=lanczos,palettegen /tmp/palette.png
# Speed of GIF playback is increased
ffmpeg -y  -i output/clip.mp4  -i /tmp/palette.png -r 10 -t 10 -filter_complex "setpts=0.6*PTS,scale=900:-1:flags=lanczos[x];[x][1:v]paletteuse" output/clip.gif
sleep 1

gnome-session-quit

# Shutdown xvfb
if [ -f /tmp/.X1-lock ]
then
  kill -9 `cat /tmp/.X1-lock`
fi
rm -f /tmp/.X1-lock