# ZAP Recorder
Generate videos/gifs of ZAP GUI interactions . Run `docker-compose up --build` and wait for an mp4 in output!

## Todo
- Improve logging handling
- Make objects for interacting with ZAP GUI
- Move recorder logic into python

## References
- https://gerardnico.com/ssh/x11/display
- https://github.com/garris/BackstopJS/blob/master/docker/xvfb-run
- https://github.com/lightsofapollo/x-recorder
- http://afterdesign.net/2016/02/07/recording-headless-selenium-tests-to-mp4.html
- https://github.com/monkpit/Beheaded/commit/43ef576311e7f889fc495b95cf59d51b3c1083da
- https://stackoverflow.com/questions/9722624/how-to-stop-ffmpeg-remotely
- https://askubuntu.com/questions/384736/how-do-i-maximize-an-already-open-gnome-terminal-window-from-command-line
- https://blog.kunst1080.net/2018/03/06/running-x-server-via-docker/
- https://github.com/kunst1080/docker-x11-base/blob/master/Dockerfile
- http://mschoofs.blogspot.com/2015/11/unknown-username-whoopsie-in-message.html
- https://github.com/sekka1/Dockerfile-Ubuntu-Gnome/blob/master/Dockerfile
- http://www.pc-freak.net/blog/gnome-appearance-modify-command-in-linux-how-to-change-theme-using-command-line-in-gnome/
- https://github.com/sekka1/Dockerfile-Ubuntu-Gnome
- https://github.com/elgalu/docker-selenium/issues/120

```sh
# In case I need them later!
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
xwininfo -root | grep '\(Width\|Height\)'
wmctrl -m
wmctrl -lG

# Make active window 100%
xdotool windowsize $(xdotool getactivewindow) 100% 100%

# Reload theme
gdbus call --session \
    --dest org.gnome.Shell \
    --object-path /org/gnome/Shell \
    --method org.gnome.Shell.Eval 'Main.loadTheme();'

# Get current theme
gsettings get org.gnome.desktop.interface gtk-theme

# Close all the windows
wmctrl -l  | cut -d' ' -f1 | xargs -I{} wmctrl -ic {}
```