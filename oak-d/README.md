# OAK-D

Note that Luxonis seems to have made some major changes to their docs.  
The previous site now has a "-old" added to the domain name, https://docs-old.luxonis.com/
The new one is https://docs.luxonis.com/

- [UVC & Disparity | How to use your OAK device as a UVC webcam](https://docs.luxonis.com/software/depthai/examples/uvc_disparity)

## Permissions

Example error message:  
`Insufficient permissions to communicate with X_LINK_UNBOOTED device with name "1.1". Make sure udev rules are set`

The fix is to add udev rule for the movidius device, unplug the device and then plugging it back into USB afterwards.
```sh
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
```
