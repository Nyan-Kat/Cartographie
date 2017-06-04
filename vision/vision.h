#ifndef DEF_VISION_H
#define DEF_VISION_H

#include <stdio.h>
#include <unistd.h>
#include "../camera/camera.h"
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
#include <fstream>
#include <sstream> 
#include <ctime>
#include "opencv2/video/tracking.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include "opencv2/line_descriptor/descriptor.hpp"

#include <ctime>
#include <fstream>
#include <string>


#include <sys/types.h>
#include <sys/stat.h>




class Vision
{
	public:
	Vision();
	~Vision();
	cv::Mat& getCVMatOut();
	cv::Mat& getCVMatIn();
	int getFramerate();
	int glPipeline();
	int nbProcessedImages;
	void get_frame();
	cv::Mat spfusion();
	float* scanImg(cv::Mat  &img);
	int get_angle(float* dist);
	void dataTotube(float *data,int size);

	void changeOutput(int relPos);
	void saveOutput();
	private:
	CCamera* m_cam;
	GfxTexture* m_ytexture,*m_utexture,*m_vtexture,*m_yreadtexture,*m_blurtexturex,*m_blurtexturexy,
	*m_greysobeltexture,*m_sobeltexture,*m_mediantexture,
	*m_rgbtextures,*m_dilatetexture,*m_erodetexture,*m_threshtexture,*m_nmftexture,*m_nmftexture2,*m_pctexture,
	*m_canny1,*m_canny2,*m_canny3,*m_slic[5],*m_texcentroidsx[5],*m_texcentroidsy[5],*m_texcentroidscolor[5],*m_spboundaries,*m_spmatchedges;
	clock_t m_time;
	cv::Mat m_img[2];
	cv::Mat m_gray,m_edge,m_sp,m_spf,m_rgb,m_spfLine;

	std::vector<GfxTexture*> m_listTexture;
	std::vector<cv::Mat> m_listMat;
	int m_selector=0;
	std::string m_imgName="../image/";
	
	const char* m_tubeNommepath="/tmp/visionData.fifo";
	std::ofstream m_tubeNomme;
	
	cv::line_descriptor::LSDDetector lineDetector;

};

#endif
