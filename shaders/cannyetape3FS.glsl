 varying vec2 tcoord;


 uniform sampler2D inputImageTexture;
 uniform vec2 texelsize;
 uniform float threshold;
 
 void main()
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

vec2 texCoords[8];

texCoords[0]=tcoord+offsets[0];
texCoords[1]=tcoord+offsets[1];
texCoords[2]=tcoord+offsets[2];
texCoords[3]=tcoord+offsets[3];
texCoords[4]=tcoord+offsets[4];
texCoords[5]=tcoord+offsets[5];
texCoords[6]=tcoord+offsets[6];
texCoords[7]=tcoord+offsets[7];	 
	 
float intensity[9];
float pixelIntensitySum=0.;

float resultat;
	 intensity[8]=texture2D(inputImageTexture, tcoord).r;
	 
	 for(int i=0;i<8;i++)
	 {
		 intensity[i]=texture2D(inputImageTexture,texCoords[i]).r;
		 pixelIntensitySum+=intensity[i];
	 }
	 
	 if(pixelIntensitySum>1.2)
	 {
		 if(intensity[8]>0.05)
		 {
			 resultat = 1.0;
		 }

	}
	else
	{
		resultat=0.0;
	}

     gl_FragColor = vec4(resultat,resultat,resultat, 1.0);
 }
