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
	QPushButton *m_button;
	QVBoxLayout *m_vlayout;
	QHBoxLayout *m_hlayout;
	QPixmap *m_pixmap;
	StreamImage *m_renderareaImage;
	StreamImage *m_renderareaImage2;
	Vision *m_vision;
	
	protected:
	void paintEvent(QPaintEvent*event);
	void keyReleaseEvent(QKeyEvent *event);

};


#endif
