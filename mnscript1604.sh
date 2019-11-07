#!/bin/bash
# This is script to run masternode on Ubuntu 16.04
# to run this script highlight and copy: 
#   wget https://raw.githubusercontent.com/bidxcore/bidx-MNScript/master/mnscript1604.sh && bash mnscript1604.sh

rm -rf bidx-ubuntu1604-b63a74d3d.tgz
wget https://github.com/bidxcore/bidx/releases/download/b63a74d3d/bidx-ubuntu1604-b63a74d3d.tgz
rm -rf bidx-ubuntu1604-b63a74d3d
tar xvf bidx-ubuntu1604-b63a74d3d.tgz
cp -f bidx-ubuntu1604-b63a74d3d/* /usr/local/bin
rm -f bidx-ubuntu1604-b63a74d3d.tgz

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
