FROM owasp/zap2docker-weekly
USER root

# Everything GUI related should be added here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y ubuntu-artwork adium-theme-ubuntu \
    light-themes ubuntu-mono x11-xserver-utils wmctrl dbus dbus-x11 xdotool ttf-mscorefonts-installer  \
    x11vnc xorg gnome-core gnome-panel gnome-settings-daemon gnome-terminal metacity indicator-applet-complete   --no-install-recommends && \
    fc-cache -f -v && \
    apt-get clean && \
    apt-get purge -y tracker* usb* account* mobile* printer*  remmina* telepathy-*  wireless* signon* && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

RUN apt-get update && \
    apt-get install -y ffmpeg libnss3 && \
    rm -rf /var/lib/apt/lists/* 

RUN pip install \
    pyautogui==0.9.38 \
    python3-xlib==0.15 \
    python-xlib==0.23 \
    opencv-python==3.4.4.19 \
    wmctrl==0.3

RUN mkdir -p /zap/shared/output && \
    mkdir -p /root/.config && \
    mkdir -p /home/zap/.config && \
    chown -R zap:zap /home/zap

COPY recorder.sh recorder.sh
COPY gui.py gui.py
ENV HOME /root
