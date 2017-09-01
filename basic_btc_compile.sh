STIME=`date`
sudo apt-get update -y
sudo apt-get install autoconf -y
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
sudo apt-get install libboost-all-dev -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
cd bitcoin
./autogen.sh
./configure --disable-tests --disable-gui-tests  --with-libs=no --without-gui
make -j4
sudo make install
ETIME=`date`
echo $STIME,$ETIME 
