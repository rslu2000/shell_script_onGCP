STIME=`date`
cd bitcoin
./autogen.sh
./configure --without-gui --disable-tests --disable-gui-tests  --with-libs=no
make -j4
sudo make install
ETIME=`date`
echo $STIME,$ETIME 
