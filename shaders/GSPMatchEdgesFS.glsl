varying vec2 tcoord;

//image contenant des contours+norme gradient+direction gradient
uniform sampler2D Iedge;

//image contentant les frontières des superpixels
uniform sampler2D Ispb;

uniform vec2 texelsize;



void main(void)
{
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

int j=0;
float pixelColor=texture2D(Ispb,tcoord).r;

float centerid1=texture2D(Ispb,tcoord).g;

float boundarie=0.;

float angle2=texture2D(Iedge,tcoord).b;

float pixelColorEdge=texture2D(Iedge,tcoord).r;


//direction du gradient
vec2 dir;
	if(angle2<=0.2)
	{
		dir=offsets[4];
	}
	else if(angle2<=0.4)
	{
		dir=offsets[2];
	}	
	else if(angle2<=0.7)
	{
		dir=offsets[1];
	}
	else
	{
		dir=offsets[0];
	}
	
	
	
		
	for(int i=0; i<8;i++)
	{
		if(abs(texture2D(Ispb,tcoord+offsets[i]).g-pixelColor)>0.)
		{
				j+=1;
		}

	}
	//Si on est sur le bord d'un superpixel
	if(j>=3)
	{

		//On se déplace de 5 pixels par pas de 1 pixel de part et d'autre dans la direction du gradient. Si on arrive sur un contour alors on met le pixel à 1.
		for(int i=0; i<10;i++)
		{
			if(texture2D(Iedge,tcoord+dir*(float(i)-5.)).r>0.)
			{
				boundarie=1.;
			}

			
		}
			//on renvoie pour chaque pixel sa luminescance d'origine, l'id du superpixel auquel  il appartient, si il est proche d'un contour
			gl_FragColor.rgb=vec3(pixelColor,centerid1,boundarie);
		//~ gl_FragColor.rgb=vec3(1.,1.,pixelColorEdges);

		
	}
	else
	{
		gl_FragColor.rgb=vec3(pixelColor,centerid1,0.);
	}
	
}
