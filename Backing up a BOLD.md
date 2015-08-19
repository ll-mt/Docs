#  Remote backup and clone of Back of Lab (BOLD)

##### Client:        Phoenix Photo
##### Created Date:  12.08.15
##### Modified Date: 19.08.15
##### Authors:       Davy Jones (TS)

---------

#### Why should I care?

Do you want to be able to take a remote backup of a BOLD that is in production and restore to a new machine for the purpose of replacment?

## 1. Purpose

Explain the process of backing up and restoring a BOLD while keeping it live and in production.

The process will utilise s3cmd for syncing files/folders from remote site to an AWS S3 bucket.

The biggest barrier with this work is the bandwidth constraints from the remote site to AWS data centre.

### AWS S3 Bucket locations

- UK sites             - eu-west-1
- European Sites       - eu-central-1
- US East Coast Sites  - us-east-1
- US West Coast Sites  - us-west-1 or us-west-2

## 2. Steps/Checklist

### List of folders to be backed up in order of preference
#### These are the config and software folder - very important!

1.  /usr/local/ambit
2.  /usr/local/lightweight-downloader-server
3.  /home/share/config
4.  /home/share/fonts
5.  /home/livelink
6.  /home/kiosk
7.  /etc/lab
8.  /var/log

#### These folders are the orders - these can be backed up locally potentially.

9.  /home/share/SharedFolders/New_Print_Orders
10. /home/share/SharedFolders/New_Prism_Orders
11. /home/share/SharedFolders/Web
12. /home/share/SharedFolders/Receipts
13. /home/share/SharedFolders/New_Poster_Orders
14. /home/share/SharedFolders/QSS
15. /home/share/SharedFolders/Albums
16. /home/share/SharedFolders/Archive

### Install and configure s3cmd on the target computer

s3cmd is built with python so going to need that, though should be there by default.
1. ssh to the target machine through Jehu
2. On ubuntu and debian based systems run:
```
    sudo apt-get install s3cmd
```
3. Download the s3cfg file from Davy's server (if timeout then speak to Davy)
  - THIS NEEDS TO BE MOVED TO SOMEWHERE LIVELINK-Y
```
    wget http://davyjones.me/s3cfg
    mv s3cfg ~/.s3cfg
```
4. Speak to InfraOps about getting credentials for an s3 bucket.
5. Open the s3cfg and update the `access_key = ` and `secret_key = ` with the information supplied by InfraOps or Tech Support.
6. Check connection by running `s3cmd ls s3://ll-ts-backup-1/`
⋅⋅⋅you should see a list of sub directories. If you get an error see the person who gave you the credentials.

### Backing up target machine's config and software folders to s3.

1. Sync the relevant folders outlined above using the following command:
```
    sudo s3cmd -r --skip-existing -H sync path/to/folder/ s3://ll-ts-backup-1/clientname-machinename/month/path/to/folder/
```

### Install lubuntu 14.04 on fresh machine
1. Speak to Warehouse about getting a new machine provisioned.
  - New machine needs a 1TB drive within minimum
2. Download lubuntu 14.04 from http://cdimage.ubuntu.com/lubuntu/releases/14.04/release/lubuntu-14.04.3-desktop-amd64.iso
3. Burn onto a live USB using unetbootin http://unetbootin.github.io/
4. Insert USB and reboot

### Bolify new machine using script
1. Download `bolify-lubuntu.sh` from http://
2. Run `chmod +x bolify-lubuntu.sh`
3. Run script as root `sudo ./bolify-lubuntu.sh`

### Add new entry to ubuntu.livelinkprint.com
1. Select `livelink-web-downloader` from New Machine? on http://ubuntu.livelinkprint.com/manage/welcome
2. Select the required Lab from dropdown
3. Product type will be `livelink-web-downloader`
4. Machine Type = CT-505
5. Input the MAC Address from the new machine
  - To get MAC address from machine run `ifconfig eth0 | grep -o "HWaddr.*"`
6. Select the following modules:
  - instand-prints
  - noritsu-barcode
  - photo-book
  - photo-collage
  - price-lists
  - prism-calendar
  - prism-cards
  - prism-gifts
  - prism-mini-calendar
  - prism-passport
  - rimage-output
  - smart-stuffers
7. Arch = 64Bit
8. Disabled = False
9. Max Version = 1.01.003 (copy this from machine you are duplicating)

### ID new machine using script
1. Download `bol-id-script.rb` from http://
2. Run script as root `sudo ruby bol-id-script.rb`

### Pulling config and software folders from s3 to new machine
<<steps to follow>>

### restart and test
Once the config and software files have been pulled in then we should only have to restart the new machine.
On reboot the machine *should* login to kiosk automatically and the `Web Order Manager` *should* startup.
You will then need to open the web browser and enter `localhost` to start the `lightweight-web-downloader`.
<<steps to follow>>

## 3. Links
