# 615 Instant Print Reset USB killing prints

##### Client: All 615 customers
##### Created Date: 10.09.15
##### Authors: Davy Jones (TS)
##### Metadata: 615;usb;instant;v170

--------

## 1. The Problem
We were getting numerous complaints from customers where during large instant print jobs the kiosk would reset, kiosk would freeze and job would need to be restarted.

This problem looked to also be related to issues that Jessops Leeds and High Wycombe were seeing where other USB devices were being blatted.

## 2. The Cause
Looking through the Ambit codebase it was seen that within ~/ambit/bin/media-helper-reset-usb a script was being called `reset-usb.sh`. Contents below:

```
#!/bin/bash

if [[ $EUID != 0 ]] ; then
  echo This must be run as root!
  exit 1
fi

for xhci in /sys/bus/pci/drivers/?hci_hcd ; do

  if ! cd $xhci ; then
    echo Weird error. Failed to change directory to $xhci
    exit 1
  fi

  echo Resetting devices from $xhci...

  for i in ????:??:??.? ; do
    echo -n "$i" > unbind
    echo -n "$i" > bind
  done
done
```

This script adopts a firebomb approach to resetting USB devices. It is only killing USB3 ports but doesn't specify by device.

## 3. The Solution

This led me to look at how to be more specific with resetting USB devices.

A lovely bit of C code held the key to the solution:
```
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <linux/usbdevice_fs.h>


int main(int argc, char **argv)
{
    const char *filename;
    int fd;
    int rc;

    if (argc != 2) {
        fprintf(stderr, "Usage: usbreset device-filename\n");
        return 1;
    }
    filename = argv[1];

    fd = open(filename, O_WRONLY);
    if (fd < 0) {
        perror("Error opening output file");
        return 1;
    }

    printf("Resetting USB device %s\n", filename);
    rc = ioctl(fd, USBDEVFS_RESET, 0);
    if (rc < 0) {
        perror("Error in ioctl");
        return 1;
    }
    printf("Reset successful\n");

    close(fd);
    return 0;
}
```

Importantly, this line:
`ioctl(fd, USBDEVFS_RESET, 0);` This runs ioctl to call USBDEVFS_RESET on a device that can be specified by its mount location **found in `lsusb`** and looks like: `/dev/bus/usb/00X/00Y`.

This means that now we can specify the device that gets reset. This specific line can also be called in Ruby adn then looped through an array of devices.

New ruby script is below:
```

#!/usr/bin/env ruby

# Reset usb devices EXCEPT printer
# written by Davy / Vicky / Stuts

require 'logger'

# Exit if not sudo
raise "This must be run as root!" unless Process.uid = 0

# DJ - creating log file
log_file = "/home/kiosk/usbreset.log"
`touch #{log_file}`
logger = Logger.new File.open(log_file, mode="w+")

# devices to be reset (MANUAL EDIT REQUIRED)
devices = ["Genesys", "ATECH", "Quanta", "Samsung"]
# devices = ["Microsoft"]

devices.each do |device|

  # ugly backticks but oneliner that gives path, do this with libusb
  path = `lsusb | grep #{device}| awk -F '[ :]'  '{ print "/dev/bus/usb/"$2"/"$4 }'`.chomp

  # imitate C file, which calls ioctl(int, USBDEVFS_RESET, 0)
  # 'U'.ord is the ASCII value for u. <<(4*2) bit shifts to the right
  # and logical OR'd with 20 (I don't know why)

  begin
  # this resets the usb device, with given path to usb (/dev/bus/usb/00X/00Y)
    File.open(path, 'wb').ioctl('U'.ord << (4*2) | 20, 0)
  rescue => err
    logger.error "Problem running USB Reset on #{device}"
    logger.err "#{err.message}"
  else
    logger.info "Successfully reset #{device}"
end
```
