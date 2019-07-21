# BIDX Masternode Setup Guide

## To Start
1. Open the "Receive" tab of your wallet
2. Click on the "Request payment" button and copy the new address generated
3. Send (exactly) 7,000 BIDX to the address that is printed
4. While this receives confirmations, perform the rest of the steps below. This will save time.
### Then
1. Open the debug console of your wallet
2. Enter command "masternode genkey"
3. Open your notepad or word processor of choice and copy this genkey in there and this is now your "mnprivkey"

Now:

a.) Choose your VPS

Suggested setup (not mandatory):

1. <https://www.vultr.com>
2. $5 Basic plan
3. Choose the location closest to you for best connection to your server.
4. Ubuntu 18.04.x64 (This choice will process a bit faster in our experience)
5. Server (Give it a magical name)

### Start an SSH session

**Depending upon which operating system you are using. Download the following software:

a.) Windows - PUTTY at <https://www.putty.org/>
or
b.) Mac/Linux - Terminal ( preinstalled ) - You can find terminal by following the steps: Go to finder, then click on utilities, then you'll find terminal there.

## Second

a.) Load the SSH terminal (Run PUTTY)

b.) Copy your IP from the VPS - And for windows Putty simply put in the IP and press enter. For Mac/Linux, use the command:

`ssh root@(yourserveripaddress)`

c.) It will connect to the server. Enter your user (root) and VPS password:

>Username: root
>
>Password: (vultr password)

** Note that if you copy (control-c) and paste (right-click) into a putty session, there is NO FEEDBACK. That means you won't see the characters being typed or pasted in. So, if you do happen to copy and paste your password in there, just right-click and press [enter]

## NOW IT IS TIME TO SET UP YOUR MASTERNODE INTO THE VPS

**This will start a process and you will need to follow the instructions displayed--have your masternode privkey (output from 'masternode genkey') ready for when the prompts on the screen ask for it

Now:

### Copy and paste this into the terminal PRESS ENTER (if you paste it into PUTTY it will usually start on its own)

`wget https://raw.githubusercontent.com/bidxcore/bidx-MNScript/master/newmnscript.sh && bash newmnscript.sh`

#### Once the script prints finished---DO NOT CLOSE THE TERMINAL

1. If you closed it, open the debug console of your wallet
2. After you verify the transaction has 15 confirmations, enter "masternode outputs" and note the transaction id (txid) of the transaction for collateral and output number (either 1 or 0)

##### Then
1. Open 'tools' menu in wallet
2. Select 'open masternode configuration file'
3. Create a new line at the bottom and enter details as follows:

`mn01 ipaddressofvps:40000 masternodekey collateraltxid collateraloutputnum`

as example:

`mn01 111.112.113.114:24999 63HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0`

Now:

1. Save your changes
2. Close the file, and then close the wallet--wait at least a minute to allow it to close properly
3. Reopen the wallet; and check the masternode tab (under 'my masternodes')
4. Wait around 5-10 minutes, right click the masternode and select "start alias".

Success. Close the terminal or PUTTY session.
