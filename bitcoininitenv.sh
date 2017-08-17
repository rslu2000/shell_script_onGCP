sudo apt-get update -y
sudo apt-get install ubuntu-desktop -y
sudo apt-get install vnc4server -y
sudo apt-get install metacity -y
sudo apt-get install gnome-panel -y
sudo apt-get install gnome-settings-daemon -y
sudo apt-get install nautilus -y
sudo apt-get install autoconf -y
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
sudo apt-get install libboost-all-dev -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y
git clone -b v0.14.2 https://github.com/bitcoin/bitcoin.git bitcoin0.14.2
cd bitcoin0.14.2
./autogen.sh
./configure --disable-tests --disable-gui-tests  --with-libs=no
make -j4
sudo make install
sudo vncserver
sudo vncserver -kill :1
cd
sudo cp xstartup .vnc/
sudo vncserver
bitcoind -daemon
sleep 6
bitcoin-cli stop
