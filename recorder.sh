#!/bin/sh
# Steps in the journey
# https://gerardnico.com/ssh/x11/display
# https://github.com/garris/BackstopJS/blob/master/docker/xvfb-run
# https://github.com/lightsofapollo/x-recorder
# http://afterdesign.net/2016/02/07/recording-headless-selenium-tests-to-mp4.html
# https://github.com/monkpit/Beheaded/commit/43ef576311e7f889fc495b95cf59d51b3c1083da
# https://stackoverflow.com/questions/9722624/how-to-stop-ffmpeg-remotely
# https://askubuntu.com/questions/384736/how-do-i-maximize-an-already-open-gnome-terminal-window-from-command-line
export DISPLAY=:1.0

if [ ! -f /tmp/.X1-lock ]
then
  echo 
  Xvfb :1 -ac -screen 0 1440x900x24  +extension RANDR &
fi

# Start window manager
openbox --replace --startup /bin/bash &

/zap/zap.sh -config start.checkForUpdates=false -config database.newsessionprompt=false -config view.uiWmHandling=1 -config start.checkAddonUpdates=false &

# xwininfo -root | grep '\(Width\|Height\)'
# wmctrl -m
# wmctrl -lG

# Wait for ZAP to load
sleep 16

# Resize to 100%
xdotool windowsize $(xdotool getactivewindow) 100% 100%

# Start recording
ffmpeg -y -r 30 -s 1440x900 -f x11grab -i :1 -g 600 -vcodec libx264 output/clip.mp4 &
VID=$!
echo "PID is $VID"

sleep 2
python gui.py
sleep 1

kill -INT $VID
sleep 5

# @todo while loop for ffmpeg
ps aux | grep ffmpeg

# Shutdown xvfb
if [ -f /tmp/.X1-lock ]
then
  kill -9 `cat /tmp/.X1-lock`
fi
rm -f /tmp/.X1-lock