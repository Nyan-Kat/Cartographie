#!/bin/bash
#https://www.theimpossiblecode.com/blog/intel-tbb-on-raspberry-pi/
#A exécuter avec droit admin (sudo) : sudo sh ....sh
cd /home/pi/Downloads
wget https://github.com/01org/tbb/archive/2017_U5.zip
unzip 2017_U5.zip
cd tbb-2017_U5
make tbb CXXFLAGS="-DTBB_USE_GCC_BUILTINS=1 -D_TBB_64BIT_ATOMICS=0" -j3

cd /home/pi/Downloads
mkdir libtbb-dev_2017_U5_armhf
cd libtbb-dev_2017_U5_armhf
mkdir -p usr/local/lib/pkgconfig
mkdir -p usr/local/include
mkdir DEBIAN


cd /home/pi/Downloads/libtbb-dev_2017_U5_armhf/DEBIAN


#Insert the description

echo "Package: libtbb-dev
Priority: extra
Section: universe/libdevel
Maintainer: Your Name <email address>
Architecture: armhf
Version: 2017.5
Homepage: http://threadingbuildingblocks.org/
Description: parallelism library for C++ - development files
 TBB is a library that helps you leverage multi-core processor
 performance without having to be a threading expert. It represents a
 higher-level, task-based parallelism that abstracts platform details
 and threading mechanism for performance and scalability.
 .
 (Note: if you are a user of the i386 architecture, i.e., 32-bit Intel
 or compatible hardware, this package only supports Pentium4-compatible
 and higher processors.)
 .
 This package includes the TBB headers, libs and pkg-config" > control


#Insert the library:



cd /home/pi/Downloads/libtbb-dev_2017_U5_armhf/usr/local/lib
cp /home/pi/Downloads/tbb-2017_U5/build/*_release/libtbb.so.2 .
ln -s libtbb.so.2 libtbb.so



#Insert the headers:


cd /home/pi/Downloads/tbb-2017_U5/include
cp -r serial tbb /home/pi/Downloads/libtbb-dev_2017_U5_armhf/usr/local/include


cd /home/pi/Downloads/libtbb-dev_2017_U5_armhf/usr/local/lib/pkgconfig
echo"
# Manually added pkg-config file for tbb - START
prefix=/usr/local
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include
Name: tbb
Description: thread building block
Version: 2017.5
Cflags: -I${includedir} -DTBB_USE_GCC_BUILTINS=1 -D__TBB_64BIT_ATOMICS=0
Libs: -L${libdir} -ltbb
# Manually added pkg-config file for tbb - END">tbb.pc


#Build the package, with correct ownership:
cd /home/pi/Downloads
sudo chown -R root:staff libtbb-dev_2017_U5_armhf
sudo dpkg-deb --build libtbb-dev_2017_U5_armhf

#Install the package

sudo dpkg -i /home/pi/Downloads/libtbb-dev_2017_U5_armhf.deb
sudo ldconfig
