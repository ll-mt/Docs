# Creating an apt-get repository
##### Authors: Davy Jones (TS)
##### Created date: 22.09.2015

--------

1. Create and publish a Signing Key with GPG

  - 1. Generate a Master Key
    
    `apt-get install rng-tools`
    
    Start rngd dameon manually using:
    `rngd -r /dev/urandom`
    
    By default rngd looks for a special device to retrieve entropy from /dev/hwrng. Some Droplets do not have this device. To compensate we use the pseudo random device /dev/urandom by specifying the -r directive. 

    Now we can generate the master key by invoking the gpg command like so:
    `gpg --gen-key`

    ```
    Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
    Your selection? 1
    ```

    By selecting the first option, gpg will generate first a signing key, then an encryption key.

    ```
    RSA keys may be between 1024 and 4096 bits long.
    What keysize do you want? (2048) 4096
    Requested keysize is 4096 bits
    ```
    
    The Debian project reccomends using 4096 bits for a signing key and Bigger is always better!
    
    ```
    Please specify how long the key should be valid.
             0 = key does not expire
          <n>  = key expires in n days
          <n>w = key expires in n weeks
          <n>m = key expires in n months
          <n>y = key expires in n years
    Key is valid for? (0) 0
    Key does not expire at all
    Is this correct? (y/N) y
    ```
    
    Master keys do not normally have expiration dates, but set this value as long as you expect to use this key. If you only plan to use this repository for only the next 6 months you can specify 6m. 0 will make it valid forever.
    
    ```    
    You need a user ID to identify your key; the software constructs the user ID
    from the Real Name, Comment and Email Address in this form:
        "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"
    
    Real name: Tom Celic
    Email address: t@c.com
    Comment: You know...
    You selected this USER-ID:
        "Tom Celic (You know...) <t@c.com>"
    
    Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
    ```
    
    You will need to input a passphrase now. Ensure you *memorise this* as there is no way to recover a gpg key.

    ```
    You need a Passphrase to protect your secret key.

    Enter passphrase: (hidden)
    Repeat passphrase: (hidden)
    ```

    It will now create a load of entropy to generate the key. Once it is done you will have your master key.

    ```
    gpg: key 231E2BB7 marked as ultimately trusted
    public and secret key created and signed.
    
    gpg: checking the trustdb
    gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
    gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
    pub   4096R/231E2BB7 2015-09-22
          Key fingerprint = AB5A 8BBB 2EFE F49B D36D  9554 BB48 C227 231E 2BB7
    uid                  Tom Celic (You know...) <t@c.com>
    sub   4096R/9C5F50AF 2015-09-22
    ```

    Make a note of your signing key ID (231E2BB7 above). We will need this to create a subkey for it.


