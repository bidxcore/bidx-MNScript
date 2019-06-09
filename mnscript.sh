#!/bin/bash
rm -rf bidx-linux64.tgz
wget https://github.com/bidxcore/releases/raw/master/linux/bidx-linux64.tgz
rm -rf bidx-linux64
tar xvf bidx-linux64.tgz
cp -f bidx-linux64/* /usr/local/bin
rm -f bidx-linux64.tgz

# find our public ip
primaryip="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)"
echo "paste the masternode privkey (output from 'masternode genkey') and press enter"
read -e masternodeprivkey

# write our masternode's .BIDX/bidx.conf
rm -f .BIDX/bidx.conf
mkdir .BIDX
echo listen=1 > .BIDX/bidx.conf
echo server=1 >> .BIDX/bidx.conf
echo daemon=1 >> .BIDX/bidx.conf
echo staking=0 >> .BIDX/bidx.conf
echo rpcuser=testuser >> .BIDX/bidx.conf
echo rpcpassword=testpassword >> .BIDX/bidx.conf
echo rpcallowip=127.0.0.1 >> .BIDX/bidx.conf
echo rpcbind=127.0.0.1 >> .BIDX/bidx.conf
echo maxconnections=24 >> .BIDX/bidx.conf
echo masternode=1 >> .BIDX/bidx.conf
echo masternodeprivkey=$masternodeprivkey >> .BIDX/bidx.conf
echo bind=$primaryip >> .BIDX/bidx.conf
echo externalip=$primaryip >> .BIDX/bidx.conf
echo masternodeaddr=$primaryip:40000 >> .BIDX/bidx.conf

bidxd
