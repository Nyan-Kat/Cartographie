cmake_minimum_required(VERSION 3.1.0)
#on dit à cmake que l'on programme en c++2011
set (CMAKE_CXX_STANDARD 11)
#drapeau permettant d'optimiser le binaire pour ARM dtocker dans la variable ARM_CVV_FLAGS
set(ARM_CXX_FLAGS "-mfloat-abi=hard -mfpu=neon -ftree-vectorize")
#nom du projet
project( vision )
SET(COMPILE_DEFINITIONS -Werror)
#cherche automatiquement l'emplacement d'OpenCv et de Qt4
find_package( OpenCV REQUIRED )
FIND_PACKAGE(Qt4 REQUIRED)
#on storcke dans la variable CMAKE_CXX_FLAGS les flags CMAKE_CXX_FLAGS+ARM_CXX_FLAGS
SET(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${ARM_CXX_FLAGS})
#on définit différentes variables contenant les sources et headers 
SET(interface_SOURCES ../interface/fenetre.cpp )
SET(interface_HEADERS ../interface/fenetre.h)
SET(shaders_SOURCES  ../shaders/)
SET(other_SOURCES ../main.cpp 
../camera/camera.h ../camera/camera.cpp  ../camera/mmalincludes.h ../camera/cameracontrol.h ../camera/cameracontrol.cpp 
../vision/vision.h ../vision/vision.cpp ../vision/graphics.h  ../vision/graphics.cpp 
../segment/disjoint-set.h ../segment/misc.h ../segment/segment-graph.h ../segment/segment-image.h  )
#Il est nécessaire pour utiliser Qt4 de lui donner les headers où on l'utilise
QT4_WRAP_CPP(interface_HEADERS_MOC ${interface_HEADERS} )
INCLUDE(${QT_USE_FILE})
ADD_DEFINITIONS(${QT_DEFINITIONS})
#différentes sources nécessaire à la bonne exécutation de la caméra et des fonctionnionalité de la raspberry pi
include_directories(/opt/vc/include)
include_directories(/opt/vc/userland-master/interface/vcos)
include_directories(/opt/vc/userland-master)
include_directories(/opt/vc/userland-master/interface/vcos/pthreads)
include_directories(/opt/vc/userland-master/interface/vmcs_host/linux)
include_directories(/opt/vc/userland-master/host_applications/linux/libs/bcm_host/include)
link_directories(/opt/vc/lib)
#le nom du programme est vision et on a besoin des sources et des librairies suivantes
add_executable(vision ${other_SOURCES} ${interface_SOURCES} ${interface_HEADERS_MOC} ${shaders_SOURCES})
target_link_libraries(vision libmmal_core.so libmmal_util.so libmmal_vc_client.so libvcos.so libbcm_host.so GLESv2 EGL ${OpenCV_LIBS} ${QT_LIBRARIES})
