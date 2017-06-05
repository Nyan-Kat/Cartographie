#ifndef DEF_FENETRE_H
#define DEF_FENETRE_H

#include <QtCore>
#include <QtGui>
#include <QObject>
#include <QDebug>
#include <QImage>
#include <QPixmap>
 
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/imgproc/types_c.h"

#include "../vision/vision.h"

//classe gérant l'affichage d'une image et le nombre d'image traité par seconde
class StreamImage:public QWidget
{
	Q_OBJECT
	public:
	StreamImage(QWidget* parent=0);
	~StreamImage();

	void setPixmap(QPixmap &pixmap);
	void setPixmap( cv::Mat &inMat);
	void setFps(int fps);
	private:
	QPixmap* m_pixmap;
	QString m_fps;
	
	protected:
	void paintEvent(QPaintEvent* event);
};

//~ 
//~ class AffichageDistance:public QWidget
//~ {
	//~ Q_OBJECT
	//~ public:
	//~ AffichageDistance(QWidget *parent=0);
	//~ void setDistance(float distance);
//~ 
	//~ private:
	//~ float m_distance;
	//~ protected:
	//~ void paintEvent(QPaintEvent*event);
//~ };



//classe de la fenetre principale
class Fenetre:public QWidget
{
	Q_OBJECT
	public:
	Fenetre();
	~Fenetre();
	QTimer* m_timer;

	
	private:
	QPushButton *m_button_quit;
	QPushButton *m_button_left;
	QPushButton *m_button_right;
	QVBoxLayout *m_vlayout;
	QHBoxLayout *m_hlayout;
	QHBoxLayout *m_hlayout_buttons;

	QPixmap *m_pixmap;
	StreamImage *m_renderareaImage; //image de gauche dans l'application
	StreamImage *m_renderareaImage2;//image de droite dans l'application
	Vision *m_vision;
	
	protected:
	void paintEvent(QPaintEvent*event);
	void keyReleaseEvent(QKeyEvent *event);
	
	public slots:
	 void change_image_l();	 
	 void change_image_r();

};


#endif
