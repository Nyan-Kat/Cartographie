varying vec2 tcoord;
uniform sampler2D inputImageTexture;
uniform vec2 texelsize;



void main(void)
{
float normeGrad,angle;
float dx;
float dy;
float xkernel[4];
xkernel[0]=-1.0;
xkernel[1]=1.0;
xkernel[2]=-1.0;
xkernel[3]=1.0;
float ykernel[4];
ykernel[0]=-1.;
ykernel[1]=-1.;
ykernel[2]=1.;
ykernel[3]=1.;
float tex[4];
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

vec2 texCoords[4];

texCoords[0]=tcoord+offsets[1];
texCoords[1]=tcoord+offsets[2];
texCoords[2]=tcoord;
texCoords[3]=tcoord+offsets[4];
	
	
	for(int i=0; i<4;i++)
	{
		tex[i]=texture2D(inputImageTexture,texCoords[i]).r;
		dx+=tex[i]*xkernel[i];
		dy+=tex[i]*ykernel[i];
	}
	dx/=2.;
	dy/=2.;
	
	normeGrad=sqrt(dx*dx+dy*dy);
	angle=atan(dy,dx);
	angle=abs(angle)/Pi;
	
	gl_FragColor=vec4(normeGrad,angle,0,1.0);
	
}
