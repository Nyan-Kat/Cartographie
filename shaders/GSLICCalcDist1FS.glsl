//coordonnée du pixel courant
varying vec2 tcoord;

//image contentant les composantes rgb ou luminescance 
uniform sampler2D I1;

//image 256*1 contentant les coordonnées x des différents centres 
uniform sampler2D I2;

//image 256*1 contentant les coordonnées y des différents centres 
uniform sampler2D I3;

//taille du superpixel (carré)
uniform float spSize;

//nombre de superpixel par ligne dans l'image
uniform int nbx;

int c;

 void main()
 {
	 

	vec2 coord=(tcoord+1.)/2.;
	
	/*
						  x=tcoord.x=tcoord[0]
				0--------------------->256 (pixels) en coordonnées de l'image
				0--------------------->1 (pixels) en coordonnées OpenGl
			0 0	______________________
			| |	|0  |1  |2  |....|15 |
			| |	|___|___|___|____|___|
  y=tcoord.y| | |16 |17 |18 |....|31 |
			| |	|___|___|___|____|___|
			| |	|         :          |
			| |	|         :          |
			| |	|_________:__________|
			| |	|240|241|242|....|255|^
			v v	|___|___|___|____|___||dy	
	     256  1          <->          v
						 dx
	nbx=16
	nby=16
	dx=dy=spSize
	
	
	La relation entre l'identifiant c du superpixel ( 0<=n<=255) et les coordonnées en pixels est :
	
	
	c=E(y/dy)*nbx+E(x/dx)
	
	avec E la partie entière 
	
	
	*/
	
	//identifiant du superpixel auquel le pixel courant appartient
	c=int(tcoord[0]*1./spSize)+int(tcoord[1]*1./spSize)*nbx;
    
	float centroidColor;
	vec2 centroidCoords;
	
	
	
	//tableau contenant les identifiants des 8 superpixels les plus proches
	float cf[9];

	//L'id du superpixel courant  S est placé en 8 dans le tableau cf

	//0 1 2
	//3 S 4   
	//5 6 7


	float distance=0.;
	float distmin=1000000.;
	float bestCenter;
	float dx;
	float dy;
	float dcoCarre;
	float dspCarre;
	
	float norm=255.;
	cf[0]=(float((c-nbx-1))/norm);
	cf[1]=(float((c-nbx))/norm);
	cf[2]=(float((c-nbx+1))/norm);
	cf[3]=(float((c-1))/norm);
	cf[4]=(float((c+1))/norm);
	cf[5]=(float((c+nbx-1))/norm);
	cf[6]=(float((c+nbx))/norm);
	cf[7]=(float((c+nbx+1))/norm);
	cf[8]=(float(c)/norm);
			
	
	float pixelColor=texture2D(I1,tcoord).r;
	
	//pour chaque superpixel on calcule une distance basée sur une moyenne pondérée de la distance spatial et chromatique entre le pixel courant et le pixel au centre du superpixel
    for(int i=0;i<9;i++)
    {

			centroidCoords=vec2(texture2D(I2,vec2(cf[i],0.)).r,texture2D(I3,vec2(cf[i],0.)).r);
			centroidColor=texture2D(I1,centroidCoords).r;
			
			dx=centroidCoords[0]-tcoord[0];
			dy=centroidCoords[1]-tcoord[1];
			
			//distance spatiale
			dspCarre=(dx*dx+dy*dy)/(spSize*spSize);
			
			//distance chromatique
			dcoCarre=(centroidColor-pixelColor)*(centroidColor-pixelColor)/(255.*255.);
			
			distance=sqrt(dspCarre*0.000001+dcoCarre);
			
			//on renvoie le centre qui est le plus proche au sens de la distance considérée
			if(distance<distmin)
			{
				distmin=distance;
				bestCenter=cf[i];
			}
		
	}
	

	float centroidColor1=texture2D(I3,vec2(cf[8],0.)).r;
	float	centroidColor2=texture2D(I2,vec2(tcoord[1],0.)).r;


  gl_FragColor.rgb = vec3(pixelColor,bestCenter,bestCenter);
 

 }
