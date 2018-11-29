
import os.path
import time
import pyautogui

pyautogui.screenshot('output/shot.png')

screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
# pyautogui.moveRel(None, 10)  # move mouse 10 pixels down
# pyautogui.doubleClick()

# Mac force to start
# pyautogui.hotkey('command', 'space')
# pyautogui.typewrite('OWASP ZAP', interval=0.01)
# pyautogui.press('enter')


# Click options
pyautogui.moveTo(270, 50, duration=0.8)
pyautogui.click()
for i in range(0, 23):
    pyautogui.hotkey('down')

pyautogui.moveRel(100, 468)
pyautogui.click()

pyautogui.press('esc')
time.sleep(1)

# Flaky image identification
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