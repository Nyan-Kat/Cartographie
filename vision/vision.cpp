#include "vision.h"
#include <thread>
#include <arm_neon.h>
#include <algorithm>
#include <math.h>
#include <chrono>
#include "../segment/segment-image.h"


#define MAIN_TEXTURE_WIDTH 256
#define MAIN_TEXTURE_HEIGHT 256
#define NB_SP 256
#define PI 3.14159265358979

//classe gérant 


//constructeur de la classe vision
Vision::Vision()
{
	//initialistation d'openGL
	InitGraphics();
	
	//initialisation camera
	m_cam = StartCamera(MAIN_TEXTURE_WIDTH, MAIN_TEXTURE_HEIGHT,30,1,false);
    
    //inititalisation cv::Mat pour les traitements CPU
	m_img[0]=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_img[1]=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_gray =cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC1); 
	m_edge =cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3); 
	m_sp=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_spf=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_spfLine=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	m_rgb=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3); 
	
	
	//permet d'assurer la compatibilité entre la mannière dont openCV stocke les images et celle d'openGL
	glPixelStorei(GL_PACK_ALIGNMENT,(m_img[0].step & 3)?1 : 4);	
	
	//inititalisation texture pour le traitement GPU	
	m_ytexture=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,true);
	m_yreadtexture=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny1=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny2=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_canny3=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_spboundaries=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_spmatchedges=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_rgbtextures=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_utexture=new GfxTexture(MAIN_TEXTURE_WIDTH/2,MAIN_TEXTURE_HEIGHT/2,true);
	m_vtexture=new GfxTexture(MAIN_TEXTURE_WIDTH/2,MAIN_TEXTURE_HEIGHT/2,true);
	m_mediantexture=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	m_blurtexturex=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	
	
	for(int i =0;i<5;i++)
	{
		m_texcentroidsx[i]=new GfxTexture();
		m_texcentroidsx[i]->CreatePixelArray(NB_SP);
		
		m_texcentroidsy[i]=new GfxTexture();
		m_texcentroidsy[i]->CreatePixelArray(NB_SP);
		
		m_texcentroidscolor[i]=new GfxTexture();
		m_texcentroidscolor[i]->CreatePixelArray(NB_SP);
		
		m_slic[i]=new GfxTexture(MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,false);
	}
	
	
	//initialisation chronometre et nombre d'image traité pour calculer les fps
	m_time=clock();
	nbProcessedImages=0;
	
	//compteur permettant de sélectionner la texture/cv::Mat à renvoyer
	m_selector=0;

	m_listTexture.push_back(m_yreadtexture);
	m_listTexture.push_back(m_rgbtextures);
	//m_listTexture.push_back(m_mediantexture);
	//m_listTexture.push_back(m_blurtexturex);
	//m_listTexture.push_back(m_canny1);
	m_listTexture.push_back(m_canny2);
	//m_listTexture.push_back(m_slic[0]);
	m_listTexture.push_back(m_spboundaries);
	m_listTexture.push_back(m_spmatchedges);

	m_listMat.push_back(m_spf);
	m_listMat.push_back(m_spfLine);

}

//destructeur vision
Vision::~Vision()
{
	delete m_ytexture,m_yreadtexture,m_canny1,
	m_canny2,m_canny3,m_spboundaries,m_spmatchedges,m_rgbtextures,
	m_utexture,m_vtexture;
	
		//~ for(int i =0;i<5;i++)
	//~ {
		//~ delete m_texcentroidsx[i];
		//~ delete m_texcentroidsy[i];
		//~ delete m_texcentroidscolor[i];
		//~ delete m_slic[i];
	//~ }
	//delete m_texcentroidsx,m_texcentroidsy,m_texcentroidscolor,m_slic;
	m_tubeNomme.open(m_tubeNommepath,std::ofstream::out);

	StopCamera();
	
}
	

// fonction permettant de déterminer le nombre  d'image traitées par seconde 
int Vision::getFramerate()
{
	
	m_time=clock()-m_time;
	
	float seconds=((float)m_time)/CLOCKS_PER_SEC;
	
	int fps=int(float(nbProcessedImages+1)/seconds);
	nbProcessedImages=0;
	m_time=clock();
	
	return fps;
}


//fonction où se déroule la chaine de traitement de l'image
int Vision::glPipeline()
{	

		
		get_frame();
		
		
		
		DrawTextureRect(m_ytexture,-1,-1,1,1,m_yreadtexture);
		DrawMedianRect(m_yreadtexture,-1.f,-1.f,1.f,1.f,m_mediantexture);
		//DrawBlurredRect(m_yreadtexture,-1.f,-1.f,1.f,1.f,m_blurtexturex);

		DrawTextureRect(m_mediantexture,-1,-1,1,1,NULL);
		glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_img[1].data);

		
		DrawCanny1Rect(m_mediantexture,-1.f,-1.f,1.f,1.f,m_canny1);
		DrawCanny2Rect(m_canny1,-1.f,-1.f,1.f,1.f,0.4f,0.8f,m_canny2);
		DrawTextureRect(m_canny2,-1,-1,1,1,NULL);
		glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_edge.data);
		
		DrawSLICCalcDistRect(m_yreadtexture,m_texcentroidsx,m_texcentroidsy,m_texcentroidscolor,-1.f,-1.f,1.f,1.f,m_slic);
		DrawSPBoudariesRect(m_slic[0],-1.f,-1.f,1.f,1.f,m_spboundaries);		
		DrawSPMatchEdgesRect(m_canny2,m_slic[0],-1.f,-1.f,1.f,1.f,m_spmatchedges);		
		DrawTextureRect(m_spmatchedges,-1,-1,1,1,NULL);
		glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_sp.data);
	
		DrawYUVTextureRect(m_ytexture,m_utexture,m_vtexture,-1.f,-1.f,1.f,1.f,m_rgbtextures);
		DrawMedianRect(m_rgbtextures,-1.f,-1.f,1.f,1.f,m_mediantexture);
		DrawTextureRect(m_mediantexture,-1,-1,1,1,NULL);
		glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_rgb.data);
				
		 m_spf=spfusion();		
		
		
		float *dist=scanImg(m_spf);
		
		dataTotube(dist,181);
		
		m_spf.copyTo(m_spfLine);
		//int thetaDir=get_angle(dist);

		//affichage des  lignes sur l'image
		int x,y;
		for(int theta=0;theta<=180;theta+=10)
		{
			
			x=int(dist[theta]*std::cos(theta*PI/180.));
			y=int(dist[theta]*std::sin(theta*PI/180.));
		
				line( m_spfLine, cv::Point(MAIN_TEXTURE_WIDTH/2,MAIN_TEXTURE_HEIGHT), cv::Point(MAIN_TEXTURE_WIDTH/2+x,MAIN_TEXTURE_HEIGHT-y), cv::Scalar(0,0,255), 1, CV_AA);
	
		}

		//~ //detection de ligne
		//~ std::vector<cv::line_descriptor::KeyLine> lines;
		//~ std::vector<cv::Vec4i> vlines;
		//~ std::vector<cv::Vec4i> hlines;
		//~ std::vector<cv::Vec2i> seplines;

		//~ lineDetector.detect(m_img[1],lines,2,2);
		//~ //cv::cvtColor(m_edge,m_gray,CV_BGR2GRAY,1);
		//~ //HoughLinesP(m_gray,lines, 1, CV_PI/180, 40, 50,10 );//minLineLength maxLineGap
	

		
		
		//~ for( int j = 0; j < lines.size(); j++ )
		  //~ {
			//~ cv::line_descriptor::KeyLine l1 = lines[j];
			//~ cv::Vec4i l;
			//~ l[0]=l1.startPointX;
			//~ l[1]=l1.startPointY;
			//~ l[2]=l1.endPointX;
			//~ l[3]=l1.endPointY;
			//~ 
			//~ if(abs(l[2]-l[0])>0.1)
			//~ {
				//~ if(abs(l[3]-l[1])/abs(l[2]-l[0])<=5.7)
				//~ {
					//~ hlines.push_back(l);
					//~ line( m_spfLine,cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), cv::Scalar(0,255,0), 1, CV_AA);
//~ 
				//~ }
				//~ else
				//~ {
					//~ vlines.push_back(l);
					//~ line( m_spfLine, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), cv::Scalar(0,255,255), 1, CV_AA);
//~ 
				//~ }
			//~ }
		  //~ }
		//~ 

		  nbProcessedImages++;
		  
		 
		  
		  changeOutput(0);
		  
		  
		  		  
		  return 1;
		  
}

//fonction permettant d'envoyer un tableau de float vers le processus python
void Vision::dataTotube(float *data,int size)
{
	
		m_tubeNomme.open(m_tubeNommepath,std::ofstream::out);

		for(int i=0;i<size;i++)
		{
			
			m_tubeNomme<<data[i]<<" ";

			
		}
		
		m_tubeNomme.close();
}

//Capture de l'image camera au format YUV
//Enregistrement des channels dans différentes textures
void Vision::get_frame()
{
		const void* frame_data; int frame_sz;
		while(!m_cam->BeginReadFrame(0,frame_data,frame_sz)) {};

		{
			const uint8_t* data = (const uint8_t*)frame_data;
			int ypitch = MAIN_TEXTURE_WIDTH;
			int ysize = ypitch*MAIN_TEXTURE_HEIGHT;
			int uvpitch = MAIN_TEXTURE_WIDTH/2;
			int uvsize = uvpitch*MAIN_TEXTURE_HEIGHT/2;
			//int upos = ysize+16*uvpitch;
			//int vpos = upos+uvsize+4*uvpitch;
			int upos = ysize;
			int vpos = upos+uvsize;
			m_ytexture->SetPixels(data);
			m_utexture->SetPixels(data+upos);
			m_vtexture->SetPixels(data+vpos);
			m_cam->EndReadFrame(0);
		}
}



//gère la fusion des superpixels via l'algorithme de Pedro F. Felzenszwalb and Daniel P. Huttenlocher
cv::Mat Vision::spfusion()
{
	cv::Mat temp=cv::Mat(MAIN_TEXTURE_HEIGHT,MAIN_TEXTURE_WIDTH,CV_8UC3);
	cv::cvtColor(m_rgb,temp,CV_BGR2HSV);
	unsigned char spId;
	unsigned int spPerimeter[NB_SP];
	unsigned int spBoundariesAsEdge[NB_SP];
	float spColorMean[3*NB_SP];
	float spColorVar[3*NB_SP];
	float spColor2Mean[3*NB_SP];
	
	unsigned int spColorSum[3*NB_SP];
	bool spIsAtABoundarie[NB_SP];
	int spCounter[NB_SP];
	
	
	for(int i=0;i<NB_SP;i++)
	{
		spPerimeter[i]=0;
		spBoundariesAsEdge[i]=0;
		spIsAtABoundarie[i]=false;
		spColorMean[3*i]=0;
		spColorSum[3*i]=0;
		spColorMean[3*i+1]=0;
		spColorSum[3*i+1]=0;
		spColorMean[3*i+2]=0;
		spColorSum[3*i+2]=0;
		spCounter[i]=0;
		spColorVar[3*i]=0.;
		spColorVar[3*i+1]=0.;
		spColorVar[3*i+2]=0.;
		spColor2Mean[3*i]=0;
		spColor2Mean[3*i+1]=0;
		spColor2Mean[3*i+2]=0;
		
	}
	
	//calcul moyenne et variance des pixels contenu dans chaque superpixel
	for(int i=0;i<MAIN_TEXTURE_HEIGHT;i++)
		{
			for(int j=0;j<MAIN_TEXTURE_WIDTH;j++)
			{
				spId=m_sp.at<cv::Vec3b>(i,j)[1];
				
				float PixelEdge=m_sp.at<cv::Vec3b>(i,j)[2];
				
				spPerimeter[spId]+=1;
				
				
				if(PixelEdge>=128.)
				{
					spBoundariesAsEdge[spId]+=1;
				}
				
				spColorSum[3*spId]+=temp.at<cv::Vec3b>(i,j)[0];
				spColorSum[3*spId+1]+=temp.at<cv::Vec3b>(i,j)[1]*0;
				spColorSum[3*spId+2]+=temp.at<cv::Vec3b>(i,j)[2]*0;
				
				spColor2Mean[3*spId]+=temp.at<cv::Vec3b>(i,j)[0]*temp.at<cv::Vec3b>(i,j)[0];
				spColor2Mean[3*spId+1]+=temp.at<cv::Vec3b>(i,j)[1]*temp.at<cv::Vec3b>(i,j)[1]*0;
				spColor2Mean[3*spId+2]+=temp.at<cv::Vec3b>(i,j)[2]*temp.at<cv::Vec3b>(i,j)[2]*0;
				
				spCounter[spId]+=1;
				//std::cout<<int(m_sp.at<cv::Vec3b>(i,j)[2])<<std::endl;
			}
			
		}
			
		
	for(int i=0;i<NB_SP;i++)
		{
			//Si le rapport nombre de pixel proche d'un bord sur le périmètre (en pixel) d'un superpixel  est assez grand alors on suppose que le superpixel est sur un bord
			if(float(spBoundariesAsEdge[i])/float(spPerimeter[i])>=0.08)
			{
				
				spIsAtABoundarie[i]=true;
					
			}
			//spColorMean[i]=float(spColorSum[i])/(float(spCounter[i])*255.);
			spColorMean[3*i]=float(spColorSum[3*i])/(float(spCounter[i]*179));
			spColorMean[3*i+1]=float(spColorSum[3*i+1])/float(spCounter[i]*255);
			//spColorMean[3*i+2]=float(spColorSum[3*i+2])/float(spCounter[i]*255);
			
			spColorVar[3*i]=float(spColor2Mean[3*i])/float(spCounter[i]*32041)-spColorMean[3*i]*spColorMean[3*i];
			spColorVar[3*i+1]=float(spColor2Mean[3*i+1])/float(spCounter[i]*65025)-spColorMean[3*i+1]*spColorMean[3*i+1];
			//spColorVar[3*i+2]=float(spColor2Mean[3*i+2])/float(spCounter[i]*65025)-spColorMean[3*i+2]*spColorMean[3*i+2];
		}
		
		
	//dimension superpixel
	float k=std::sqrt(float(MAIN_TEXTURE_WIDTH*MAIN_TEXTURE_HEIGHT)/NB_SP);
	//nombre de superpixel par ligne
	int nbx=int(float(MAIN_TEXTURE_WIDTH)/k);
	//nombre de superpixel par colonne
	int nby=int(float(MAIN_TEXTURE_HEIGHT)/k);
		
	int num_ccs;

	int *segmentedSP=segment_image(spColorMean,spColorVar,spIsAtABoundarie,nbx,nby,1,1.5,&num_ccs);
	

	
	for(int i=0;i<MAIN_TEXTURE_HEIGHT;i++)
		{
			for(int j=0;j<MAIN_TEXTURE_WIDTH;j++)
			{
				
				spId=m_sp.at<cv::Vec3b>(i,j)[1];

				if(segmentedSP[spId]==segmentedSP[229]||segmentedSP[spId]==segmentedSP[230]
				||segmentedSP[spId]==segmentedSP[231]|segmentedSP[spId]==segmentedSP[232]
				||segmentedSP[spId]==segmentedSP[233]
				||segmentedSP[spId]==segmentedSP[245]
				||segmentedSP[spId]==segmentedSP[246]
				||segmentedSP[spId]==segmentedSP[247]
				||segmentedSP[spId]==segmentedSP[248]
				||segmentedSP[spId]==segmentedSP[249]
				)
				{
					float tempcolor=m_rgb.at<cv::Vec3b>(i,j)[0];
					temp.at<cv::Vec3b>(i,j)[0]=m_rgb.at<cv::Vec3b>(i,j)[2];
					temp.at<cv::Vec3b>(i,j)[1]=m_rgb.at<cv::Vec3b>(i,j)[1];
					temp.at<cv::Vec3b>(i,j)[2]=tempcolor;
				
				 //~ temp.at<cv::Vec3b>(i,j)[0]=255;
				 //~ temp.at<cv::Vec3b>(i,j)[1]=255;
				 //~ temp.at<cv::Vec3b>(i,j)[2]=255;
			    }
			    else
			    {
					temp.at<cv::Vec3b>(i,j)[0]=0;
					temp.at<cv::Vec3b>(i,j)[1]=0;
					temp.at<cv::Vec3b>(i,j)[2]=0;
				}
				
			}
			
		}				
	return temp;
	
	
}




//permet de "scanner" l'image. on trace des lignes en ppartie du milieu basd de l'image jusqu'a trouver un pixel noir=obstacle
float* Vision::scanImg(cv::Mat &img)
{
	
	float k=std::sqrt(float(MAIN_TEXTURE_WIDTH*MAIN_TEXTURE_HEIGHT)/NB_SP);
	int nbx=int(float(MAIN_TEXTURE_WIDTH)/k);
	int nby=int(float(MAIN_TEXTURE_HEIGHT)/k);
	
	float l=k;
	
	float *dist=new float[180];
	for(int i=0;i<180;i++)
	{
		dist[i]=0;
		
	}
	
	for(int theta=0;theta<=180;theta++)
	{
		float x=0.;
		float y=0.;
		int n=0;
		while(true)
		{
			x=n*l*std::cos(theta*PI/180.);
			y=n*l*std::sin(theta*PI/180.);

			if((std::abs(x)>=float(MAIN_TEXTURE_WIDTH/2) && std::abs(y)>=float(MAIN_TEXTURE_HEIGHT))
			|| (int(img.at<cv::Vec3b>(int(MAIN_TEXTURE_HEIGHT-y),int(MAIN_TEXTURE_WIDTH/2+x))[0])==0 
			&& int(img.at<cv::Vec3b>(int(MAIN_TEXTURE_HEIGHT-y),int(MAIN_TEXTURE_WIDTH/2+x))[1])==0 
			&& int(img.at<cv::Vec3b>(int(MAIN_TEXTURE_HEIGHT-y),int(MAIN_TEXTURE_WIDTH/2+x))[2])==0))
			{
				
				break;
			}
			
			n++;
		}
		dist[theta]=float(n)*l;
	}	
	
	return dist;
}



int Vision::get_angle(float* dist)
{
	
	if(dist[90]<=MAIN_TEXTURE_HEIGHT*0.667)
	{
		return std::distance(dist,std::max_element(dist+10,dist+170));
	}
	else
	{
		return 90;
		
	}
	
	
	
	
}

//int Vision::convertPixeltoDist(float height,float anglefocal,





//renvoie l(='image d'entree
cv::Mat& Vision::getCVMatIn()
{
	return m_img[1];
	
}


//renvoie l'image de sortie
cv::Mat& Vision::getCVMatOut()
{
	return m_img[0];
	
}

//permet de changer l'image de sortie en sélectionnant l'image avec une position relative de relPos par rapport à l'image courante dans la liste [texture1,texture2...,cv:Mat1,...]
void Vision::changeOutput(int relPos)
{
		m_selector+=relPos;
		//si <0 on retourne à la fin de la liste d'images
		if(m_selector<0)
		{
			m_selector=m_listTexture.size()+m_listMat.size()-1;
		}
		//sinon si on dépasse la fin on retourne au début
		else if(m_selector>m_listTexture.size()+m_listMat.size()-1)
		{
			
			m_selector=0;
		}
		
		//si on est dans la partie cv::Mat on peut directement copier l'image dans le cv:Mat de sortie
		if(m_selector>=m_listTexture.size())
		{
			m_listMat[m_selector-m_listTexture.size()].copyTo(m_img[0]);
			
		}
		//sinon on charge la texture depuis le GPU vers le CPU dans le cv:MAt
		else if(m_selector>=0)
		{
			DrawTextureRect(m_listTexture[m_selector],-1,-1,1,1,NULL);
			glReadPixels(0,0,MAIN_TEXTURE_WIDTH,MAIN_TEXTURE_HEIGHT,GL_RGB,GL_UNSIGNED_BYTE,m_img[0].data);

		}

		
}


//permet de sauvegarder l'image courante sous le nom m_selector.jpg
void Vision::saveOutput()
{	
	std::string chaine=m_imgName+std::to_string(m_selector)+std::string(".jpg");
	std::cout<<chaine;
	cv::imwrite( chaine.data(), m_img[0] );
	
	
}
