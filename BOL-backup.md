#  Remote backup and clone of Back of Lab (BOLD)

## Client:        Phoenix Photo
## Created Date:  12.08.15
## Modified Date: 12.08.15
## Authors:       Davy Jones (TS)

---------

## 1. Purpose
Explain the process of backing up and restoring a BOLD while keeping it live and in production.

The process will utilise s3cmd for syncing files/folders from remote site to an AWS S3 bucket.

The biggest barrier with this work is the bandwidth constraints from the remote site to AWS data centre.

### AWS S3 Bucket locations
UK sites             - eu-west-1
European Sites       - eu-central-1
US East Coast Sites  - us-east-1
US West Coast Sites  - us-west-1 or us-west-2

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

### Install and configure s3cmd
s3cmd is built with python so going to need that, though should be there by default.
1. On ubuntu and debian based systems run:
    sudo apt-get install s3cmd
2. 
## 3. Links
