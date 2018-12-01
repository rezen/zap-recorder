#!/bin/sh

HERE="$PWD"
mkdir -p $HOME/.config/nautilus
chown -R zap:zap /home/zap

export DISPLAY=:1.0
export XKL_XMODMAP_DISABLE=1

if [ ! -f /tmp/.X1-lock ]
then
  # @todo make screen size configureable
  Xvfb :1 -ac -screen 0 1440x900x24  +extension RANDR &
fi

# Start window manager
# @todo log to specific file
gnome-session &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
xhost +

# @todo adjust logging
su - zap -c "/zap/zap.sh -addonupdate -config start.installAddonUpdates=true -config quickstart.launch.defaultBrowser=Firefox -config start.checkForUpdates=true -config database.newsessionprompt=false -config view.uiWmHandling=1 -config start.checkAddonUpdates=true &"

# Wait for ZAP to load
sleep 6
sh -c 'tail -f /home/zap/.ZAP_D/zap.log  | { grep -m 1 "New Session" && echo ZAP_READY &&  kill $$ ;}'

# Make ZAP full screen
wmctrl -ir $(wmctrl -l | grep ZAP | cut -d' ' -f1)  -b add,maximized_vert,maximized_horz
sleep 1

# Start recording
ffmpeg -y -r 30 -s 1440x900 -f x11grab -i :1 -g 600 -vcodec libx264 output/clip.mp4 &
VID=$!

# Start GUI interactions
sleep 1
python gui.py
sleep 1

# Kill recording
# @todo while loop until ffmpeg dies
kill -INT $VID
sleep 5

gnome-session-quit

# Shutdown xvfb
if [ -f /tmp/.X1-lock ]
then
  kill -9 `cat /tmp/.X1-lock`
fi
rm -f /tmp/.X1-lock