#include "vision.h"

#define MAIN_TEXTURE_WIDTH 320
#define MAIN_TEXTURE_HEIGHT 240
Vision::Vision()
{
	InitGraphics();
	m_cam = StartCamera(MAIN_TEXTURE_WIDTH, MAIN_TEXTURE_HEIGHT,50,1,false);
    
	m_img[0]=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_img[1]=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_gray =cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC1); 
	
	glPixelStorei(GL_PACK_ALIGNMENT,(m_img[0].step & 3)?1 : 4);	
		
	m_ytexture=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,true);
	m_yreadtexture=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny1=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny2=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny3=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	
	m_time=clock();
	nbProcessedImages=0;
	
	a=false;
}

Vision::~Vision()
{
	delete m_ytexture,m_yreadtexture,m_canny1,m_canny2,m_canny3;
	
	StopCamera();
	

}
	
	
int Vision::getFramerate()
{
	
	m_time=clock()-m_time;
	
	float seconds=((float)m_time)/CLOCKS_PER_SEC;
	
	int fps=int(float(nbProcessedImages+1)/seconds);
	nbProcessedImages=0;
	m_time=clock();
	
	return fps;
}

int Vision::glPipeline()
{		
		m_img[1]=m_img[0].clone();
		
	    BeginFrame();
		const void* frame_data; int frame_sz;
		while(!m_cam->BeginReadFrame(0,frame_data,frame_sz)) {};

		{
			const uint8_t* data = (const uint8_t*)frame_data;
			m_ytexture->SetPixels(data);

			m_cam->EndReadFrame(0);
		}

		DrawTextureRect(m_ytexture,-1,-1,1,1,m_yreadtexture);
		DrawCanny1Rect(m_yreadtexture,-1.f,-1.f,1.f,1.f,m_canny1);
		DrawCanny2Rect(m_canny1,-1.f,-1.f,1.f,1.f,0.4f,0.8f,m_canny2);

		
		DrawTextureRect(m_canny2,-1,-1,1,1,NULL);
		glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_img[0].data);
		
		cv::cvtColor(m_img[0],m_gray,cv::COLOR_RGB2GRAY);
		
		
		/*std::vector<cv::Vec2f> lines;
		HoughLines(gray, lines, 1, CV_PI/180, 80, 0, 0 );

		for( int k = 0; k < lines.size(); k++ )
		{
		 float rho = lines[k][0], theta = lines[k][1];
		 cv::Point pt1, pt2;
		 double a = cos(theta), b = sin(theta);
		 double x0 = a*rho, y0 = b*rho;
		 pt1.x = cvRound(x0 + 1000*(-b));
		 pt1.y = cvRound(y0 + 1000*(a));
		 pt2.x = cvRound(x0 - 1000*(-b));
		 pt2.y = cvRound(y0 - 1000*(a));
		 line( gray, pt1, pt2, cv::Scalar(255,0,255), 1);
		}*/
        
		std::vector<cv::Vec4i> lines;
		
		HoughLinesP(m_gray, lines, 1, CV_PI/180, 50, 50,10 );//minLineLength maxLineGap
		m_img[0]=cv::Scalar(255,255,255)-m_img[0];
		std::vector<cv::Vec4i> angleasuivre;
		for( int j = 0; j < lines.size(); j++ )
		  {
			cv::Vec4i l = lines[j];
			line( *m_img, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), cv::Scalar(0,0,255), 1, CV_AA);
		  }
		  nbProcessedImages++;
		  EndFrame();
		  
		  
		  return 1;
		  
	
}


cv::Mat& Vision::getCVMat()
{
	return m_img[0];
	
}
