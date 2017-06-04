#pragma once

#include "GLES2/gl2.h"
#include "EGL/egl.h"
#include "EGL/eglext.h"
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
void InitGraphics();
void ReleaseGraphics();
void BeginFrame();
void EndFrame();

class GfxShader
{
	GLchar* Src;
	GLuint Id;
	GLuint GlShaderType;

public:

	GfxShader() : Src(NULL), Id(0), GlShaderType(0) {}
	~GfxShader() { if(Src) delete[] Src; }

	bool LoadVertexShader(const char* filename);
	bool LoadFragmentShader(const char* filename);
	GLuint GetId() { return Id; }
};

class GfxProgram
{
	GfxShader* VertexShader;
	GfxShader* FragmentShader;
	GLuint Id;

public:

	GfxProgram() {}
	~GfxProgram() {}

	bool Create(GfxShader* vertex_shader, GfxShader* fragment_shader);
	GLuint GetId() { return Id; }
};

class GfxTexture
{
	int Width;
	int Height;
	GLuint Id;
	bool IsRGBA;

	GLuint FramebufferId;
public:

	GfxTexture() : Width(0), Height(0), Id(0), FramebufferId(0) {}
	GfxTexture(int width, int height,bool grey);
	~GfxTexture() {}

	bool CreateRGBA(int width, int height, const void* data = NULL);
	bool CreateGreyScale(int width, int height, const void* data = NULL);
	bool CreatePixelArray(int width,const void* data=NULL);
	bool setPixelArray(const void* data=NULL);


	bool GenerateFrameBuffer();
	void SetPixels(const void* data);
	GLuint GetId() { return Id; }
	GLuint GetFramebufferId() { return FramebufferId; }
	int GetWidth() {return Width;}
	int GetHeight() {return Height;}
};


void DrawTextureRect(GfxTexture* texture, float x0, float y0, float x1, float y1, GfxTexture* render_target);
void DrawYUVTextureRect(GfxTexture* ytexture, GfxTexture* utexture, GfxTexture* vtexture, float x0, float y0, float x1, float y1, GfxTexture* render_target);

void DrawCanny1Rect(GfxTexture* texture, float x0, float y0, float x1, float y1, GfxTexture* render_target);
void DrawCanny2Rect(GfxTexture* texture, float x0, float y0, float x1, float y1, float thrdown,float thrup, GfxTexture* render_target);
void DrawCanny3Rect(GfxTexture* texture, float x0, float y0, float x1, float y1,float thr,GfxTexture* render_target);

void DrawSLICCalcDistRect(GfxTexture* texture1,GfxTexture* texture2[],GfxTexture* texcentroidsy[],GfxTexture* texcentroidcolor[], float x0, float y0, float x1, float y1,GfxTexture* render_target[]);
void DrawSPBoudariesRect(GfxTexture* spboundaries,float x0, float y0, float x1, float y1,GfxTexture* render_target)
;
void DrawBlurredRect(GfxTexture* texture, float x0, float y0, float x1, float y1, GfxTexture* render_target);
void DrawMedianRect(GfxTexture* texture, float x0, float y0, float x1, float y1, GfxTexture* render_target)
;
void DrawSPMatchEdgesRect(GfxTexture* edge,GfxTexture* spboundaries,float x0, float y0, float x1, float y1,GfxTexture* render_target);
