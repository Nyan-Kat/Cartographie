 varying vec2 tcoord;


 uniform sampler2D inputImageTexture;
 uniform float centroids[800];
 uniform float spSize;
 uniform float threshold;
 uniform int nbx:

int c=0;

 void main()
 {
	 
	//0 1 2
	//3 s 4   
	//5 6 7


  c=int(tcoord[0]*1./spSize)+int(tcoord[1]*1./spSize)*nbx;
	 


     gl_FragColor = vec4(float(c%4)/4.);
 }
