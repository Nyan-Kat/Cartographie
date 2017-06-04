
#include <QApplication>
#include "interface/fenetre.h"
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include "vision/vision.h"



int main(int argc, char **argv)
{
	QApplication app(argc, argv);
	
	Fenetre test;
    test.showFullScreen();
 
    return app.exec();
	/*Vision test;
	for(int i=0;i<10000;i++)
	{
		test.glPipeline();
		cv::namedWindow("test",cv::WINDOW_NORMAL);
		//cv::setWindowProperty("test",cv::WND_PROP_FULLSCREEN,cv::WINDOW_FULLSCREEN);
		cv::imshow("test",test.getCVMatOut());
		if(cv::waitKey(1)>=0)
		  {
			//cv::imwrite( "image/glimageedge.jpg", img );
			cv::destroyWindow("test");
			break;
		  }
	}*/
}
