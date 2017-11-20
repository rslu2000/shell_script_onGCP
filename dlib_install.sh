# 编译dlib前先安装cmake、boost函式庫、python-pip
sudo apt-get install cmake libboost-all-dev python-pip -y

# 开始编译dlib
# 克隆dlib源代码

 git clone https://github.com/davisking/dlib.git
 cd dlib
 mkdir build
 cd build
 cmake .. -DDLIB_USE_CUDA=0 -DUSE_AVX_INSTRUCTIONS=1
 cmake --build .
 cd ..
 sudo python setup.py install --yes USE_AVX_INSTRUCTIONS --no DLIB_USE_CUDA
