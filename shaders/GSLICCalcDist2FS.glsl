varying vec2 tcoord;

uniform sampler2D I1;
uniform sampler2D I2;
uniform sampler2D I3;
uniform sampler2D I4;

uniform float spSize;

uniform int nbx;


int c;

 void main()
 {
	 
	//0 1 2
	//3 s 4   
	//5 6 7
	vec2 tex=texture2D(I1,tcoord).rb;
    float pixelColor=tex[0];
    
    c=int(tex[1]*255.);
    
	float centroidColor;
	vec2 centroidCoords;
	float cf[9];

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
			
	
	
	
    for(int i=0;i<9;i++)
    {

			centroidCoords=vec2(texture2D(I2,vec2(cf[i],0.)).r,texture2D(I3,vec2(cf[i],0.)).r);
			centroidColor=texture2D(I4,vec2(cf[i],0.)).r;
			//~ centroidColor=texture2D(I1,centroidCoords).r;
			dx=centroidCoords[0]-tcoord[0];
			dy=centroidCoords[1]-tcoord[1];
			
			dspCarre=(dx*dx+dy*dy)/(spSize*spSize);
			
			dcoCarre=(centroidColor-pixelColor)*(centroidColor-pixelColor)/(255.*255.);//(centroidColor-pixelColor)*(centroidColor-pixelColor)/(255.*255.);
			
			distance=sqrt(dspCarre*0.00001+dcoCarre);
			
			if(distance<distmin)//distance<distmin
			{
				distmin=distance;
				bestCenter=centroidColor;
			}
		
	}
	

//~ 
float centroidColor1=texture2D(I2,vec2(cf[8],0.)).r;
float	centroidColor2=texture2D(I2,vec2(tcoord[1],0.)).r;


  gl_FragColor.rgb = vec3(pixelColor,bestCenter,bestCenter);//vec4(0.,0.,color2,0.);//texture2D(I2,tcoord).r;;
 

 }
