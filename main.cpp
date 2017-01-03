
#include <QApplication>
#include "interface/fenetre.h"
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include "vision.h"

#define MAIN_TEXTURE_WIDTH 320
#define MAIN_TEXTURE_HEIGHT 240

d
int main(int argc, char **argv)
{
	QApplication app(argc, argv);
	
	Fenetre test;
    test.showFullScreen();
 
    return app.exec();
/*	Vision test;
	for(int i=0;i<1000;i++)
	{
		test.glPipeline();
		cv::namedWindow("test",cv::WINDOW_NORMAL);
		//cv::setWindowProperty("test",cv::WND_PROP_FULLSCREEN,cv::WINDOW_FULLSCREEN);
		cv::imshow("test",test.getCVMat());
		if(cv::waitKey(1)>=0)
		  {
			//cv::imwrite( "image/glimageedge.jpg", img );
			cv::destroyWindow("test");
			break;
		  }
	}*/
}
