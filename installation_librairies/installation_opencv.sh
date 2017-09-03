#!/bin/bash
#https://www.theimpossiblecode.com/blog/intel-tbb-on-raspberry-pi/
#https://www.pyimagesearch/2015/10/26/how-to-install-opencv-3-on-raspbian-jessie/
#A exécuter avec droit admin (sudo) : sudo sh installation_opencv.sh

sudo apt-get install build-essential git cmake pkg-config
sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev lib4l-dev
sudo apt-get install libxvidcore-dev libx264-dev

sudo apt-get install install libgtk-3-dev

sudo apt-get install install libatlas-base-dev gfortran

sudo apt-get install install python2.7-dev python3.5-dev

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install numpy

cd /home/pi/Downloads

wget -O opencv-3.2.0.zip https://github.com/opencv/opencv/archive/3.2.0.zip 
wget -O opencv-3.2.0-contrib.zip https://github.com/opencv/opencv_contrib/archive/3.2.0.zip
unzip  opencv-3.2.0.zip
unzip opencv-3.2.0-contrib.zip

cd /home/pi/Downloads/opencv-3.2.0
mkdir build
cd build
cmake -DBUILD_EXAMPLES=ON -DINSTALL_C_EXAMPLES=ON -D_INSTALL_PYTHON_EXAMPLES=ON -DOPENCV_EXTRA_MODULES_PATH=/home/pi/Downloads/opencv_contrib-3.2.0/modules -DCMAKE_CXX_FLAGS="-DTBB_USE_GCC_BUILTINS=1 -D__TBB_64BIT_ATOMICS=0" -DENABLE_VFPV3=ON -DENABLE_NEON=ON -DBUILD_TESTS=OFF -DWITH_TBB=ON -DWITH_GTK_2_X=ON -DCMAKE_BUILD_TYPE=Release ..
make -j3

sudo make install
#~ sudo apt-get install checkinstall
#~ echo "opencv 3.2.0 build_rpi3_release_fp_tbb" > description-pak
#~ echo | sudo checkinstall -D --install=yes --pkgname=opencv --pkgversion=3.2.0 --provides=opencv --nodoc --backup=no

cd /usr/local/lib/python3.5/dist-packages
sudo mv cv2.cpython-34m.so  cv2.so
