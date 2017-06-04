
varying vec2 tcoord;
//image contenant poour chaque pixel l'identifiant du superpixel dont il est le plus proche
uniform sampler2D I1;

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
float pixelColor=texture2D(I1,tcoord).g;
	
	
	//on regarde les 8 pixels voisins et on compte le nombre de pixels dont l'identifiant est différents
	for(int i=0; i<8;i++)
	{
		if(abs(texture2D(I1,tcoord+offsets[i]).g-pixelColor)>0.)
		{
				j+=1;
		}

	}
	//Si on a plus de 3 pixels différents, c'est qu'on est vraisemblablement sur le bord d'un superpixel=>pixel blanc
	if(j>=3)
	{
		gl_FragColor.rgb=vec3(1.,1.,0.);
	}
	//Sinon pixel noir
	else
	{
		gl_FragColor.rgb=vec3(0.,0.,0.);
	}
	
}


