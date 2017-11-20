#ref. https://www.learnopencv.com/install-opencv3-on-ubuntu/

sudo apt-get update -y
sudo apt-get upgrade -y
#Remove any previous installations of x264
sudo apt-get remove x264 libx264-dev -y

sudo apt-get install build-essential checkinstall cmake pkg-config yasm gfortran git -y
sudo apt-get install libjpeg8-dev libjasper-dev libpng12-dev -y
sudo apt-get install libtiff5-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev -y
sudo apt-get install libxine2-dev libv4l-dev -y
sudo apt-get install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libqt4-dev libgtk2.0-dev libtbb-dev -y
sudo apt-get install libatlas-base-dev -y
sudo apt-get install libfaac-dev libmp3lame-dev libtheora-dev -y
sudo apt-get install libvorbis-dev libxvidcore-dev -y
sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev -y
sudo apt-get install x264 v4l-utils -y
#Optional dependencies
sudo apt-get install libprotobuf-dev protobuf-compiler -y
sudo apt-get install libgoogle-glog-dev libgflags-dev -y
sudo apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen -y
#Install Python libraries
sudo apt-get install python-dev python-pip python3-dev python3-pip -y
sudo -H pip2 install -U pip numpy
sudo -H pip3 install -U pip numpy
#Download opencv from Github
git clone https://github.com/opencv/opencv.git
cd opencv 
git checkout 3.3.0 
cd ..
#Download opencv_contrib from Github
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.3.0
cd ..
#Compile and install OpenCV with contrib modules
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..

make -j4
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
