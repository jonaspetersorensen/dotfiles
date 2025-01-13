# This script should run in windows.
# This script is a workaround for reattaching oak-d to wsl at a faster pace than usbipd --reattach (which really should be good enough, but oh well...)
#
# Reason:
# Luxonis demo code will quite often restart oak-d and then _instantly_ check if it is available.
# This check will fail when using usbipd to connect usb devices to wsl due to rebooting a usb device will automatically disconnect the device from usb.
# Binding the device with "usbipd --reattach" should normally be enough, but it does not happen at quick enough pace for Luxonis software.
# Hence we have to manually spam "check and reattach" every 0.5 second to avoid Luxonis software failing.
#
# The Real Fix:
# Luxonis software should loop "check for device" for a couple of seconds to give the device time to get back online before failing.

import time
import os
while True:
    output = os.popen('usbipd list').read() # List all USB devices
    rows = output.split('\n')
    for row in rows:
        if ('Movidius MyriadX' in row or 'Luxonis Device' in row) and 'Shared' in row: # Check for OAK cameras that aren't attached
            busid = row.split(' ')[0]
            out = os.popen(f'usbipd attach --wsl --busid {busid}').read() # Attach an OAK camera
            print(out)
            print(f'Usbipd attached Myriad X on bus {busid}') # Log
    time.sleep(.5)
