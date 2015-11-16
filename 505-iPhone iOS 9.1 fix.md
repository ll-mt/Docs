# 505 iOS v9.1 issue pulling images fix

##### Client: Seen on Snappy Chiswick machines
##### Created Date: 28.10.15
##### Authors: Davy Jones (TS)
##### Metadata: 505;iphone;ios;9.1

--------

## 1. The Problem
It was witnesed on a 505 that John from Snappy Snaps Chiswick brought in that when connecting an iPhone running iOS 9.1 using a lightning cable it would not do anything, not load images etc.

Looking in the session log file located in `/home/share/logs/` we can see the following messages:

> Attempting to mount iDevice
> No device found, is it connected?
> If it is make sure that your user has permissions to access the raw usb device.
> If you're still having issues try unplugging the device and reconnecting it.

It is worth noting that the iDevice is plugged into a USB3 port on the 505.

By swapping the port to a USB2 port we get a different error message:

> Checking for iDevice...
> Retrying mounting iDevice
> Fusermount: /media/iphone not mounted
> Failed to connect to lockdownd service on the device.
> Try again. If it still fails try rebooting your device.

lockdownd service relates to the UUID of the device.

## Troubleshoot process

1. Customer complains about iPhone not showing images
2. Get them to plug device in while tailing the relevant log file through SSH.
3. If you get the first error showing about that relates to `No Device Found` then get the user to change the USB port type that the device is plugged into.
4. Once this is done you will either get the images loaded or you will get the second error `Failed to connect to lockdownd service on the device.`
5. Now we need to go have a look in the `/usr/local/ambit/sbin/notify` file.
6. Go to line77. You should see that the next blocks is commented with `=begin` and `=end`.
7. The block looks like this:
```Ruby
	   5.times {
             `fusermount -u /media/iphone`
             `ifuse /media/iphone/ -o ro,nonempty,allow_other`
             if `mount`.include?("/media/iphone")
               fp.puts "Mounted iDevice successfully"
               exit 0
             else
               sleep 3
             end
           }
```
8. Once this is uncommented then save the file.
9. Kill the current session with `sudo killall -u kiosk`
10. Get the user to reconnect their iPhone. You should now see the images begin to load.
11. If not then try something else.


