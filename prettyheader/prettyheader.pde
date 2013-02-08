/* Convexhull to stl export
 * by Ben Leduc-Mills
 * 10.5.10
*/

import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;

//init STL object
STL stl;
//init quickhull
QuickHull3D hull = new QuickHull3D();
//init Point3d array
Point3d[] points;
//number of points
int numPoints = 50;


void setup() {
  
  size(900, 150, P3D);
  stroke(150);
  //populate point3d array with random xyz coordinates
  Point3d[] points = new Point3d[numPoints];
  for(int i = 0; i < numPoints; i++) { 
    points[i] = new Point3d (random(200), random(125), random(100));   
  }
  hull.build (points);
  smooth();
}

void draw() {
  background(255);
  translate(width/2, height/2 -50, 0);
  //lights();
  //rotateY(frameCount * 0.01);  
  
  Point3d[] vertices = hull.getVertices();

  beginShape();  
   //println ("Faces:");
   int[][] faceIndices = hull.getFaces();
   //print(faceIndices.length);
   for (int i = 0; i < faceIndices.length; i++) {  
     for (int k = 0; k < faceIndices[i].length; k++) {
       
        //print (faceIndices[i][k] + " ");
        
        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        //print(pnt2);
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
       }
      //println ("");
    }
    
endShape();
}

//if any key is pressed, output the STL file
void keyPressed() {
  outputSTL();
}

//function to output STL file
void outputSTL() {
  
   stl=(STL)beginRaw("unlekker.data.STL","convexhull.stl");
   
   Point3d[] vertices = hull.getVertices();
   
   beginShape(QUADS);  
   //println ("Faces:");
   int[][] faceIndices = hull.getFaces();
   //print(faceIndices.length);
   for (int i = 0; i < faceIndices.length; i++) {  
     for (int k = 0; k < faceIndices[i].length; k++) {
       
        //print (faceIndices[i][k] + " ");
        
        Point3d pnt2 = vertices[faceIndices[i][k]];
        print(pnt2);
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
       }
      //println ("");
    }
    
endShape(CLOSE);
endRaw();
}

