#  Remote backup and clone of Back of Lab (BOLD)

##### Client:        Phoenix Photo
##### Created Date:  12.08.15
##### Modified Date: 12.08.15
##### Authors:       Davy Jones (TS)

---------

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
3. Download the s3cfg file from Davy's Digital Ocean Account
```
    wget http://davyjones.me/s3cfg
    mv s3cfg ~/.s3cfg
```
4. Open the s3cfg and update the `access_key = ` and `secret_key = ` with the information supplied by InfraOps or Tech Support.
5. Check connection by running `s3cmd ls s3://ll-ts-backup-1/`
⋅⋅⋅you should see a list of sub directories. If you get an error see the person who gave you the credentials.

### Backing up target machine's config and software folders to s3.

1. Sync the relevant folders outlined above using the following command:
```
    sudo s3cmd -r --skip-existing -H sync path/to/folder/ s3://ll-ts-backup-1/clientname-machinename/month/path/to/folder/
```
### Install lubuntu 14.04 on fresh machine
<<steps to follow>>
### Bolify new machine using script
<<steps to follow>>
### ID new machine using script
<<steps to follow>>
### Pulling config and software folders from s3 to new machine
<<steps to follow>>
### restart and test
<<steps to follow>>
## 3. Links
