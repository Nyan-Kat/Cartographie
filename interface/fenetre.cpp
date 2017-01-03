#include "fenetre.h"
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <QTimer>
#include <math.h>
#include <time.h>
time_t timer;
double seconds;
struct tm y2k ={0};


 /**
   Functions to convert between OpenCV's cv::Mat and Qt's QImage and QPixmap.
 
   Andy Maloney
   https://asmaloney.com/2013/11/code/converting-between-cvmat-and-qimage-or-qpixmap
**/
   // NOTE: This does not cover all cases - it should be easy to add new ones as required.
QImage  cvMatToQImage( const cv::Mat &inMat )
{
  switch ( inMat.type() )
  {
	 // 8-bit, 4 channel
	 case CV_8UC4:
	 {
		QImage image( inMat.data,
					  inMat.cols, inMat.rows,
					  static_cast<int>(inMat.step),
					  QImage::Format_ARGB32 );

		return image;
	 }

	 // 8-bit, 3 channel
	 case CV_8UC3:
	 {
		QImage image( inMat.data,
					  inMat.cols, inMat.rows,
					  static_cast<int>(inMat.step),
					  QImage::Format_RGB888 );

		return image.rgbSwapped();
	 }

	 // 8-bit, 1 channel
	 case CV_8UC1:
	 {
		static QVector<QRgb>  sColorTable( 256 );

		// only create our color table the first time
		if ( sColorTable.isEmpty() )
		{
		   for ( int i = 0; i < 256; ++i )
		   {
			  sColorTable[i] = qRgb( i, i, i );
		   }
		}

		QImage image( inMat.data,
					  inMat.cols, inMat.rows,
					  static_cast<int>(inMat.step),
					  QImage::Format_Indexed8 );

		image.setColorTable( sColorTable );

		return image;
	 }

	 default:
		qWarning() << "ASM::cvMatToQImage() - cv::Mat image type not handled in switch:" << inMat.type();
		break;
  }

  return QImage();
}
 
QPixmap cvMatToQPixmap( const cv::Mat &inMat )
{
  return QPixmap::fromImage( cvMatToQImage( inMat ) );
}























StreamImage::StreamImage(QWidget * parent):QWidget(parent)
{
	m_pixmap=new QPixmap;
	m_fps.setNum(0);
}
StreamImage::~StreamImage()
{
	
	delete m_pixmap;
}
void StreamImage::setPixmap(QPixmap &pixmap)
{
	
	*m_pixmap=pixmap;
	
	
}
void StreamImage::setPixmap(cv::Mat &inMat)
{
	*m_pixmap=cvMatToQPixmap(inMat);

	
}
void StreamImage::setFps(int fps)
{
	m_fps.setNum(fps);
	
}

 
void StreamImage::paintEvent(QPaintEvent* event)
{
	if(!m_pixmap)
	{
		return;
	}
	QPainter p;
	p.begin(this);
	p.drawPixmap(rect(),*m_pixmap,m_pixmap->rect());
		
	p.drawText(QRect(10,10,20,20),Qt::AlignCenter|Qt::TextDontClip,m_fps);
	
	p.end();
}
 
AffichageDistance::AffichageDistance(QWidget * parent):QWidget(parent)
{
	m_distance=0.;

}
	

void AffichageDistance::paintEvent(QPaintEvent*event)
{
	time(&timer);
	seconds=difftime(timer,mktime(&y2k));
	
	QPainter p;
	QBrush brush;

	float width=float(this->width());
	float height=float(this->height());
	float circleWidth=width*(2.-sin(seconds*2.*3.14*1./50.))/3.;
	float circleHeight=circleWidth;//height*(2.-sin(seconds*2.*3.14*1./100.))/3.;
	p.begin(this);
	p.setRenderHint(QPainter::Antialiasing);
	brush=QBrush(QColor(230,255,252));
	p.fillRect(this->rect(),brush);
	//p.setBrush(QBrush(QColor(50,150,200)));
	p.setPen(QPen(QColor(255,0,0)));
	p.drawArc(QRectF((width-circleWidth)/2.,(height-circleHeight)/2.,circleWidth,circleHeight),0,16*360);
	p.drawText(QRectF((width/2.-circleWidth/2.),(height/2.-circleHeight/2.),circleWidth,circleHeight),Qt::AlignCenter|Qt::TextDontClip,QString::number(circleWidth/width));
	p.drawText(QRectF(10.,10.,width,height),Qt::AlignHCenter|Qt::TextDontClip|Qt::AlignTop,"Distance balise");

	p.end();
	
}
void AffichageDistance::setDistance(float distance)
{
		m_distance=distance;
}

Fenetre::Fenetre() :QWidget()
{
	//setFixedSize(600,600);
	
	m_button=new QPushButton("Quitter");
	
	m_vlayout= new QVBoxLayout;
	m_hlayout= new QHBoxLayout;
	m_renderareaImage= new StreamImage;
	m_renderareaUWB= new AffichageDistance;
	
	//m_renderareaImage->setPixmap(m_pixmap);
	
	m_vlayout->addWidget(m_button);
	m_vlayout->addWidget(m_renderareaUWB);
	
	m_hlayout->addWidget(m_renderareaImage);
	m_hlayout->addLayout(m_vlayout);
	
	this->setLayout(m_hlayout);	
	
	m_vision=new Vision;
	
	m_timer=new QTimer(this);
	m_timer->setInterval(33);
	QObject::connect(m_timer,SIGNAL(timeout()),this,SLOT(repaint()));
	
	//connection slots signaux
	
	QObject::connect(m_button,SIGNAL(clicked()),this,SLOT(close()));
	
	m_timer->start();
}


void Fenetre::paintEvent(QPaintEvent *event)
{
	
	m_vision->glPipeline();
	if((m_vision->nbProcessedImages+1)%10==0)
	{
		m_renderareaImage->setFps(m_vision->getFramerate());
	}
	m_renderareaImage->setPixmap(m_vision->getCVMat());
	
	m_timer->start();

}



Fenetre::~Fenetre()
{
	
	
	delete m_vision;
	delete m_timer;
	
}
StreamImage *Fenetre::ptrRenderareaImage()
{
	return m_renderareaImage;
}

AffichageDistance *Fenetre::ptrRenderareaUWB()
{
	return m_renderareaUWB;
}
