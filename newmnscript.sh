#!/bin/bash

# to run this script:  wget https://raw.githubusercontent.com/bidxcore/bidx-MNScript/master/newmnscript.sh && bash newmnscript.sh

# checks if we have a swapfile which allows an operating system to use hard disk space to simulate extra memory

memory="$(free | grep Swap | tr -s ' ' | cut -d ' ' -f 4)"
if [ -n "$memory" ] && [ "$memory" -eq "$memory" ] 2>/dev/null; then
  if [ "$memory" -eq "0" ]; then
      # make a quick 1gb swap as we only need it for compilation
      dd if=/dev/zero of=/var/swap.img bs=1024k count=1000
          mkswap /var/swap.img
          swapon /var/swap.img
          echo enabled temporary swapfile..
    else
          # a suitable swap file exists
      echo swapfile not required..
  fi
else
  # if we dont understand this, you need a new linux
  echo tell your linux distribution to go get a job
  exit
fi

# install the dependencies
apt update
apt install -y build-essential autoconf automake libssl-dev libdb5.3-dev libdb5.3++-dev libboost-all-dev pkg-config libtool libevent-dev git screen

# build bidx
git clone https://github.com/bidxcore/bidx
cd bidx
./autogen.sh
./configure --with-incompatible-bdb --disable-tests
make install
cd

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
