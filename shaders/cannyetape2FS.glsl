//suppression des pixels dont la valeur du gradient est non maximal


//coordonnee du pixel
varying vec2 tcoord;
//image d'entree
uniform sampler2D inputImageTexture;
uniform float upperThreshold;
uniform float lowerThreshold;
//taille d'un pixel
uniform vec2 texelsize;

void main(void)
{	
	
if(abs(tcoord[0])>0.99 || abs(tcoord[1])>0.99)
{
	 	gl_FragColor=vec4(0.);
}
else
{
float normeGrad,angle;
vec2  tex[3];
float resultat;
float Pi;
Pi=3.141592653589;


	//0 1 2
	//3 s 4   
	//5 6 7



vec2 offsets[8];

offsets[0]=vec2(-texelsize.x,texelsize.y);
offsets[1]=vec2(0.,texelsize[1]);
offsets[2]=vec2(texelsize[0],texelsize[1]);
offsets[3]=vec2(-texelsize[0],0.);
offsets[4]=vec2(texelsize[0],0.);
offsets[5]=vec2(-texelsize[0],-texelsize[1]);
offsets[6]=vec2(0.,-texelsize[1]);
offsets[7]=vec2(texelsize[0],-texelsize[1]);
	
vec2  texCoords[3];

	texCoords[0]=tcoord;
	tex[0]=texture2D(inputImageTexture,tcoord).xy;
	normeGrad=tex[0].x;
	angle=tex[0].y;
	int angle2=int(floor((angle-Pi/16.)*4.));
	
	//la valeur d'angle2 correspond à :
	
	//3 2 1
	//0	s 0
	//1 2 3
	
	
	//On calcule les coordonnées des points dans la direction du gradient
	if(angle2==0)
	{
		texCoords[1]=tcoord+offsets[4];
		texCoords[2]=tcoord+offsets[3];
	}
	else if(angle2==1)
	{
		texCoords[1]=tcoord+offsets[2];
		texCoords[2]=tcoord+offsets[5];
	}	
	else if(angle2==2)
	{
		texCoords[1]=tcoord+offsets[1];
		texCoords[2]=tcoord+offsets[6];
	}
	else if(angle2==3)
	{
		texCoords[1]=tcoord+offsets[0];
		texCoords[2]=tcoord+offsets[7];
	}
	
	
	//On prélève les points dans la direction du gradient
	for(int i=1;i<3;i++)
	{
		tex[i]=texture2D(inputImageTexture,texCoords[i]).xy;
	}
	
	//Si la norme du gradient est > à un certain seuil on le considère maximal quelque soit ses voisins
	if(normeGrad>0.7)
	{
		resultat=1.;
	}
	//Sinon si elle est plus petite que celle de ses ses voisins dans le sens du gradient alors on met le pixel sortant à 0
	else if(normeGrad<tex[1].x || normeGrad<tex[2].x)
	{
		resultat=0.;
	}
	//Sinon elle est plus grande que ses voisins et qu'elle n'est pas plus petite qu'un certain seuil, alors on met le pixel sortant à 1
	else
	{
		if(normeGrad<0.03)
		{
				resultat=0.;
		}
		else
		{
			resultat=1.;
		}
	}
	
	gl_FragColor=vec4(resultat,resultat,float(angle2)/3.,float(angle2)/3.);
	
}
}
