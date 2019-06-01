# BIDX Masternode Setup Guide

## First

a.) Choose your VPS

Suggested setup (not mandatory):

<https://www.vultr.com>
$5 Basic plan
Choose the location closest to you for best connection to your server.
Ubuntu 16.04.x64
Server (Give it a magical name)

### Start an SSH session

**Depending upon which operating system you are using. Download the following software:

Windows - PUTTY at <https://www.putty.org/>
Mac/Linux - Terminal ( preinstalled ) - You can find terminal by following the steps: Go to finder, then click on utilities, then you'll find terminal there.

## Second

a.) Load the SSH terminal (Run PUTTY)

b.) Copy your IP from the VPS - And for windows Putty simply put in the IP and press enter. For Mac/Linux, use the command:

`ssh root@(yourserveripaddress)`

c.) It will connect to the server. Enter your user (root) and VPS password:

>Username: root
>Password: (vultr password)

** Note that if you copy (control-c) and paste (right-click) into a putty session, there is NO FEEDBACK. That means you won't see the characters being typed or pasted in. So, if you do happen to copy and paste your password in there, just right-click and press [enter]

## NOW IT IS TIME TO SET UP YOUR MASTERNODE INTO THE VPS

**This will start a process and you will need to follow the instructions displayed--have your masternode privkey (output from 'masternode genkey') ready for when the prompts on the screen ask for it

Now:

### Copy and paste this into the terminal

`wget https://raw.githubusercontent.com/bidxcore/bidx-MNScript/master/mnscript.sh && bash mnscript.sh`

#### Once the script prints finished

1. Open the debug console of your windows wallet
2. Enter "getaccountaddress mn01" at the prompt
3. Send (exactly) 7,000 BIDX to the address that is printed
4. After 15 confirms, enter masternode outputs and note the transaction id (txid) of the transaction for collateral and output number (either 1 or 0)
5. Open 'tools' menu in wallet
6. Select 'open masternode configuration file'
7. Create a new line at the bottom and enter details as follows:

`mn01 ipaddressofvps:24999 masternodekey collateraltxid collateraloutputnum`

as example:

`mn01 111.112.113.114:24999 63HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0`

Now:

1. Save your changes
2. Close the file, and then close the wallet
3. Reopen the wallet; and check the masternode tab (under 'my masternodes')
4. Wait around 5-10 minutes, right click the masternode and select start.

Success.
