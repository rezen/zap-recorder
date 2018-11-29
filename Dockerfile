FROM owasp/zap2docker-weekly
USER root
RUN pip install pyautogui python3_xlib python-xlib opencv-python
RUN apt-get update && apt-get install -y x11-xserver-utils wmctrl  dbus-x11 xdotool ffmpeg
COPY assets/menu.xml /var/lib/openbox/debian-menu.xml
COPY assets/rc.xml /var/lib/openbox/debian-rc.xml

USER zap
RUN mkdir -p /zap/shared/output
COPY recorder.sh recorder.sh
COPY gui.py gui.py