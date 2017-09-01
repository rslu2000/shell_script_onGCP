sudo apt-get install gcc g++ -y
sudo apt-get install make -y
wget https://nodejs.org/dist/v8.1.2/node-v8.1.2.tar.gz 
tar xvf node-v8.1.2.tar.gz
cd node-v8.1.2
./configure
make -j4
sudo make install
