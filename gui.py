
import os.path
import time
import pyautogui
from subprocess import call
from wmctrl import Window

print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
zap_main = Window.by_class('sun-awt-X11-XFramePeer.OWASP')[0]
print(zap_main)
zap_main.set_properties(['add','maximized_vert','maximized_horz'])


pyautogui.screenshot('output/shot.png')

screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
# pyautogui.moveRel(None, 10)  # move mouse 10 pixels down
# pyautogui.doubleClick()

# Mac force to start
# pyautogui.hotkey('command', 'space')
# pyautogui.typewrite('OWASP ZAP', interval=0.01)
# pyautogui.press('enter')


# Quick launch
pyautogui.moveTo(910, 78, duration=0.8)
pyautogui.click()
time.sleep(6)
zap_main.activate()
# What is hotkey to minimize window?
# pyautogui.hotkey('alt', 'f9')
# https://bitbucket.org/antocuni/wmctrl/src/
# firefox = Window.get_active()
# firefox.set_properties("remove,maximized_horz,maximized_vert")

# call(['xdotool', 'getactivewindow', 'windowminimize'])

# Click options
pyautogui.moveTo(270, 78, duration=0.8)
pyautogui.click()
for i in range(0, 23):
    pyautogui.hotkey('down')

pyautogui.moveRel(100, 468)
pyautogui.click()

pyautogui.press('esc')
time.sleep(1)

# Flaky image identification
# https://docs.opencv.org/3.4.0/d4/dc6/tutorial_py_template_matching.html
if os.path.exists('assets/gear.png'):
    coords = pyautogui.locateOnScreen('assets/gear.png')
    print(coords)

# Expand sites
# @todo

# Hotkey for alerts
# pyautogui.hotkey('command', 'shift', 'a')
# For linux ctrl alt replaces command
pyautogui.hotkey('ctrl', 'alt', 'shift', 'a')
time.sleep(2)