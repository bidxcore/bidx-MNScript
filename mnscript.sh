    
#!/bin/bash
#
# masternode from scratch (baz 20032019)
# i remember a time when youd get knocked out asking for binaries (!)

# check if we have swap
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
  # if we dont understand this, update linux
  An update to latest Linux is required.
  exit
fi

# install the dependencies
apt update
apt install -y build-essential autoconf automake libssl-dev libdb5.3-dev libdb5.3++-dev libboost-all-dev pkg-config libtool libevent-dev git screen

# build fusionx
git clone https://github.com/bidxcore/bidx
cd FusionX
./autogen.sh
./configure --with-incompatible-bdb --disable-tests
make install
cd

# find our public ip
primaryip="$(ip route get 1 | awk '{print $NF;exit}')"
echo "This is where you paste the masternode privkey (output from 'masternode genkey') and press enter"
read -e masternodeprivkey

# write our masternode's .fusion/fusion.conf
mkdir .fusion
echo listen=1 > .fusion/fusion.conf
echo server=1 >> .fusion/fusion.conf
echo daemon=1 >> .fusion/fusion.conf
echo staking=0 >> .fusion/fusion.conf
echo rpcuser=testuser >> .fusion/fusion.conf
echo rpcpassword=testpassword >> .fusion/fusion.conf
echo rpcallowip=127.0.0.1 >> .fusion/fusion.conf
echo rpcbind=127.0.0.1 >> .fusion/fusion.conf
echo maxconnections=24 >> .fusion/fusion.conf
echo masternode=1 >> .fusion/fusion.conf
echo masternodeprivkey=$masternodeprivkey >> .fusion/fusion.conf
echo bind=$primaryip >> .fusion/fusion.conf
echo externalip=$primaryip >> .fusion/fusion.conf
echo masternodeaddr=$primaryip:24999 >> .fusion/fusion.conf

# sleep because sleeping is good.. sometimes
sleep 1
fusiond

# finished
echo finished
