# A little tip for if a customer is being a dick with their touchscreen.
##### Created date: 25/08/15
##### Authors: Josh Empson (TS)


The following instructions will display a list of input devices (touchscreen is underlined, the important bit made bold).
Then display a list of properties associated with the input device specified (property is underlined, important bit made bold).
Finally it will disable the touchscreen, so that customers cannot arse with it.
(NOTE: This has especially useful for labs that put a piece of paper up to mark a kiosk as Out of Order).
(Ripped from http://www.nico.schottelius.org/blog/xorg-disable-touchpad-with-xinput/)

```
$ DISPLAY=:0.0 xinput list

Virtual core pointer                    	id=2	[master pointer  (3)]
   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
   ↳ QUANTA OpticalTouchScreen               	id=8	[slave  pointer  (2)]
Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Power Button                            	id=7	[slave  keyboard (3)]

$ DISPLAY=:0.0 xinput list-props 8 

Device 'QUANTA OpticalTouchScreen':
	Device Enabled (114):	1
	Device Accel Profile (235):	0
	Device Accel Constant Deceleration (236):	1.000000
	Device Accel Adaptive Deceleration (238):	1.000000
	Device Accel Velocity Scaling (239):	10.000000
	Evdev Reopen Attempts (231):	10
	Evdev Axis Inversion (240):	0, 0
	Evdev Axis Calibration (241):	<no items>
	Evdev Axes Swap (242):	0
	Axis Labels (243):	"Abs X" (233), "Abs Y" (234), "None" (0), "None" (0), "None" (0)
	Button Labels (244):	"Button Unknown" (232), "Button Unknown" (232), "Button Unknown" (232), "Button Wheel Up" (118), "Button Wheel Down" (119)
	Evdev Middle Button Emulation (245):	2
	Evdev Middle Button Timeout (246):	50
	Evdev Wheel Emulation (247):	0
	Evdev Wheel Emulation Axes (248):	0, 0, 4, 5
	Evdev Wheel Emulation Inertia (249):	10
	Evdev Wheel Emulation Timeout (250):	200
	Evdev Wheel Emulation Button (251):	4
	Evdev Drag Lock Buttons (252):	0

$ DISPLAY=:0.0 xinput set-prop 8 144 0
```

To check that the touchscreen has indeed been disabled, run the second command again and you should get the line below:

>Device 'QUANTA OpticalTouchScreen':
	Device Enabled (114):	0

To re-enable the touchscreen, you can either reboot the machine or do it the super-cool way:

`$ DISPLAY=:0.0 xinput set-prop 8 144 1`

Any problems understanding this, let me know.
Otherwise, enjoy the feeling of power of people's touchscreens.
