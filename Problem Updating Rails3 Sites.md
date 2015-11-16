# Problem Updating Rails3 Sites
##### Created Date: 02.10.15
##### Authors: Davy Jones

 # Are you missing all your print options after a software update?
 # Try resaving the print prices in mylab.
 # WebKiosk::Service.get('print').basic_service_options(true) will be
 # an empty array until the prices are resaved (fix it, I dare you)

# Symptoms

After updating web kiosk software. All print options were missing from [http://dscolour.photokio.sk/order/slingshot?service=print](http://dscolour.photokio.sk/order/slingshot?service=print).

Even when the software was rolled back to a previous version the provlem still remained.

# The Cause




broken
  not displaying any products

caus price lis:2


git checkout --reset 
