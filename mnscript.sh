#!/bin/bash

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
primaryip="$(ip route get 1 | awk '{print $NF;exit}')"
echo "This is where you paste the masternode privkey (output from 'masternode genkey') and then press enter"
read -e masternodeprivkey

# write our masternode's .bidx/bidx.conf
mkdir .bidx
echo listen=1 > .bidx/bidx.conf
echo server=1 >> .bidx/bidx.conf
echo daemon=1 >> .bidx/bidx.conf
echo staking=0 >> .bidx/bidx.conf
echo rpcuser=testuser >> .bidx/bidx.conf
echo rpcpassword=testpassword >> .bidx/bidx.conf
echo rpcallowip=127.0.0.1 >> .bidx/bidx.conf
echo rpcbind=127.0.0.1 >> .bidx/bidx.conf
echo maxconnections=24 >> .bidx/bidx.conf
echo masternode=1 >> .bidx/bidx.conf
echo masternodeprivkey=$masternodeprivkey >> .bidx/bidx.conf
echo bind=$primaryip >> .bidx/bidx.conf
echo externalip=$primaryip >> .bidx/bidx.conf
echo masternodeaddr=$primaryip:24999 >> .bidx/bidx.conf

# sleep because sleeping is good
sleep 1
bidxd

# finished
echo Finished
