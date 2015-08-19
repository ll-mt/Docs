# Costco Remote Kiosk themepack naming problem

##### Client: Costco
##### Created Date: 19.08.15
##### Authors: Davy Jones (TS)
##### Metadata: costco;remote;themepacks;typo
--------

## 1. The Problem
On Costco Remote Kiosk (ver. 2.99.134) there is a problem with the calender themepacks causing a fatal error when selecting a Calender.

This can be reproduced by doing the following:

1. Image Kiosk with <need image name>
2. ID kiosk
3. Enable and configure Web Kiosk connection
4. Click on Kiosk screen
5. Select Calendars
6. Accept EULA
7. Enter Membership details
8. Click Load Images
9. IT WILL FAIL AND AMBIT WILL CRASH

## 2. The Cause
The error eludes to a themepack entitled "calendarsfj.themepack" and within here a specific pack named "geopatterns_12x12.calendar"

Within this folder there is no about.yml, no nothing!

This is because there is another folder entitled "geopatterns_12x12calendar" (notice the lack of a fullstop!). This folder contains all the bits that you need and is the correct folder.

On further investigation it is seen that the Walmart themepacks are being downloaded to this image thus there are many products that are supurfilous.


## 3. The Solution
1. Archive the empty folder `mkdir archive && mv geopatterns_12x12.calender /archive`
2. rename the mis-spelt folder `mv geopatterns_12x12calendar geopatterns_12x12.calendar`

**18/08/15** Separate dot release of Kiosk software due that removes unnessesary thempacks
