apt-get update -y
apt-get install autoconf -y
apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
apt-get install libboost-all-dev -y
apt-get install software-properties-common -y
add-apt-repository ppa:bitcoin/bitcoin -y
apt-get update -y
apt-get install libdb4.8-dev libdb4.8++-dev -y
apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y
apt-get install git -y
git clone -b v0.12.0 https://github.com/bitcoin/bitcoin.git bitcoin0.12.0
cd bitcoin0.12.0
./autogen.sh
./configure
make -j4
make install
bitcoind -daemon
sleep 3
bitcoin-cli stop
