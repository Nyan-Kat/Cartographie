//coordonnee du pixel
varying vec2 tcoord;
//image d'entree
uniform sampler2D inputImageTexture;
//taille d'un pixel
uniform vec2 texelsize;



void main(void)
{
float normeGrad,angle;
//coordonnee en x du gradient
float dx;
//coordonnee en y du gradient
float dy;

//noyaux de convolution
float gx[4];
gx[0]=-1.0;
gx[1]=1.0;
gx[2]=-1.0;
gx[3]=1.0;
float gy[4];
gy[0]=-1.;
gy[1]=-1.;
gy[2]=1.;
gy[3]=1.;
float tex[4];
float Pi;


Pi=3.141592653589;

//pour chaque pixel courant s on consière ses 8 plus proches voisins
	//0 1 2
	//3 s 4   
	//5 6 7

//offset contient la distance entre le pixel s et l'un de ses voisins
vec2 offsets[8];

offsets[0]=vec2(-texelsize.x,texelsize.y);
offsets[1]=vec2(0.,texelsize[1]);
offsets[2]=vec2(texelsize[0],texelsize[1]);
offsets[3]=vec2(-texelsize[0],0.);
offsets[4]=vec2(texelsize[0],0.);
offsets[5]=vec2(-texelsize[0],-texelsize[1]);
offsets[6]=vec2(0.,-texelsize[1]);
offsets[7]=vec2(texelsize[0],-texelsize[1]);


vec2 texCoords[4];
//coordonnee pixel 1
texCoords[0]=tcoord+offsets[1];
//coordonnee pixel 2
texCoords[1]=tcoord+offsets[2];
//coordonnee pixel courant s
texCoords[2]=tcoord;
//coordonnee pixel 3
texCoords[3]=tcoord+offsets[4];
	
	//calcul du gradient moyenne sur 2 pixels
	for(int i=0; i<4;i++)
	{
		tex[i]=texture2D(inputImageTexture,texCoords[i]).r;
		dx+=tex[i]*gx[i];
		dy+=tex[i]*gy[i];
	}
	
	dx/=2.;
	dy/=2.;
	
	normeGrad=sqrt(dx*dx+dy*dy);
	angle=atan(dy,dx);
	angle=abs(angle)/Pi;
	
	gl_FragColor=vec4(normeGrad,angle,0,1.0);
	
}
