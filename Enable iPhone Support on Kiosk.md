# How to enable iPhone support on a Physical Kiosk

##### Created: 19.08.15
##### Authors: Davy Jones (TS)

--------

# 1. What

If during testing it is seen that the Kiosk does not have iPhone input enabled then follow the below steps to enable it.

# 2. How

1. Go to http://ubuntu.livelinkprint.com
  - Go to the info page of the required kiosk
  - Click on `Edit`
  - Under `Modules` tick `iphone-loader`
  - Click `Save changes`

2. On Physical Kiosk
  - Run `vim /home/share/config/Kiosk.xmlv`
  - Check if "enable-iphone" is true
  - If not enter: `:%s/enable-iphone">false/enable-iphone">true/`
  - Then enter ambit-shell using `/usr/local/ambit/shell`
  - Update Kiosk with `ambit-update --force`
  - Reboot kiosk

# 3. Why

This happens when you don't enable all modules on http://ubuntu.livelinkprint.com.
Historically, not all modules were enabled so that certain features could be chargeable extras, particular features that aren't desired by the customer can be disabled from their control panel or Kiosk.xmlv.
