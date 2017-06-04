/*
Copyright (C) 2006 Pedro Felzenszwalb

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
*/

#ifndef SEGMENT_IMAGE
#define SEGMENT_IMAGE

#include <cstdlib>
#include "misc.h"
#include "segment-graph.h"

// dissimilarity measure between pixels
static inline float diff(float *color,float *var,bool *spIsAtABoundarie,
			 int pos1, int pos2) {
				/* if(spIsAtABoundarie[pos1]||spIsAtABoundarie[pos2])
				 {
					 
					return sqrt(square(color[pos1]-color[pos2]))*15.;	 
				}
				else
				{
						return sqrt(square(color[pos1]-color[pos2]));	 
					
				}*/
	
			 if(spIsAtABoundarie[pos1]||spIsAtABoundarie[pos2])
				 {
					 
					return sqrt(
					square(color[3*pos1]-color[3*pos2])+
					square(color[3*pos1+1]-color[3*pos2+1])+
					square(color[3*pos1+2]-color[3*pos2+2])+
					
					(square(var[3*pos1]-var[3*pos2])+
					square(var[3*pos1+1]-var[3*pos2+1])+
					square(var[3*pos1+2]-var[3*pos2+2]))*1.4
					
					)*10.;	 
				}
				else
				{
					return sqrt(
					square(color[3*pos1]-color[3*pos2])+
					square(color[3*pos1+1]-color[3*pos2+1])+
					square(color[3*pos1+2]-color[3*pos2+2])*
					
					(square(var[3*pos1]-var[3*pos2])+
					square(var[3*pos1+1]-var[3*pos2+1])+
					square(var[3*pos1+2]-var[3*pos2+2]))*1.4
					
					);						
				}
				 

}

/*
 * Segment an image
 *
 * Returns a color image representing the segmentation.
 *
 * im: image to segment.
 * sigma: to smooth the image.
 * c: constant for treshold function.
 * min_size: minimum component size (enforced by post-processing stage).
 * num_ccs: number of connected components in the segmentation.
 */
int *segment_image(float *color,float *var,bool *spIsAtABoundarie,int nbx,int nby,float c, int min_size,
			  int *num_ccs) {
  int width = nbx;
  int height = nby;

 
  // build graph
  edge *edges = new edge[width*height*4];
  int num = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (x < width-1) {
	edges[num].a = y * width + x;
	edges[num].b = y * width + (x+1);
	edges[num].w = diff(color,var,spIsAtABoundarie,y * width + x,y * width + (x+1));
	num++;
      }

      if (y < height-1) {
	edges[num].a = y * width + x;
	edges[num].b = (y+1) * width + x;
	edges[num].w = diff(color,var,spIsAtABoundarie,y * width + x,(y+1) * width + x);
	num++;
      }

      if ((x < width-1) && (y < height-1)) {
	edges[num].a = y * width + x;
	edges[num].b = (y+1) * width + (x+1);
	edges[num].w = diff(color,var,spIsAtABoundarie,y * width + x,(y+1) * width + (x+1));
	num++;
      }

      if ((x < width-1) && (y > 0)) {
	edges[num].a = y * width + x;
	edges[num].b = (y-1) * width + (x+1);
	edges[num].w = diff(color,var,spIsAtABoundarie,y * width + x,(y-1) * width + (x+1));
	num++;
      }
    }
  }

  // segment
  universe *u = segment_graph(width*height, num, edges, c);
  
  // post process small components
  for (int i = 0; i < num; i++) {
    int a = u->find(edges[i].a);
    int b = u->find(edges[i].b);
    if ((a != b) && ((u->size(a) < min_size) || (u->size(b) < min_size)))
      u->join(a, b);
  }
  delete [] edges;
  *num_ccs = u->num_sets();
 
  int *output= new int[width*height];

  // pick random colors for each component
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int comp = u->find(y * width + x);
      output[y * width + x] = comp;
    }
  }  
 
 
  delete u;

  return output;
}

#endif
