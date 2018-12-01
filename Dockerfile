FROM owasp/zap2docker-weekly
USER root

# Everything GUI related should be added here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y ubuntu-ui-toolkit-theme ubuntu-artwork \
    light-themes ubuntu-mono x11-xserver-utils wmctrl dbus dbus-x11 xdotool \
    x11vnc xorg gnome-core gnome-panel gnome-settings-daemon gnome-terminal --no-install-recommends && \
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

RUN mkdir -p /zap/shared/output
COPY recorder.sh recorder.sh
COPY gui.py gui.py
ENV HOME /root
