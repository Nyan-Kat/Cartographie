#ifndef DEF_VISION_H
#define DEF_VISION_H

#include <stdio.h>
#include <unistd.h>
#include "camera/camera.h"
#include "graphics.h"
#include <time.h>
#include <curses.h>
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include "GLES2/gl2.h"
#include "EGL/egl.h"
#include "EGL/eglext.h"
#include <vector>
#include <iostream>
#include <sstream> 
#include <ctime>

#include "opencv2/video/tracking.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/calib3d/calib3d.hpp"

#include <ctime>
#include <fstream>
#include <string>
class Vision
{
	public:
	Vision();
	~Vision();
	cv::Mat& getCVMat();
	int getFramerate();
	int glPipeline();
	int nbProcessedImages;
	void traj();
	
	
	private:
	CCamera* m_cam;
	GfxTexture* m_ytexture,*m_yreadtexture,*m_blurtexturex,*m_blurtexturexy,
	*m_greysobeltexture,*m_sobeltexture,*m_mediantexture,
	*m_redtexture,*m_dilatetexture,*m_erodetexture,*m_threshtexture,*m_nmftexture,*m_nmftexture2,*m_pctexture,
	*m_canny1,*m_canny2,*m_canny3;
	clock_t m_time;
	cv::Mat m_img[2];
	cv::Mat m_gray;
	std::vector<cv::Point2f>m_points1;
	std::vector<cv::Point2f>m_points2;
	bool a;
};

#endif
