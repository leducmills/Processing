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
  
  size(800, 800, P3D);
  
  //populate point3d array with random xyz coordinates
  Point3d[] points = new Point3d[numPoints];
  for(int i = 0; i < numPoints; i++) { 
    points[i] = new Point3d (random(50), random(50), random(50));   
  }
  hull.build (points);
}

void draw() {
  background(255);
  translate(width/2, height/2 -50, 500);
  //lights();
  rotateY(mouseX * 0.01);
  rotateX(mouseY * 0.01);  
  
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
  
  if (key == 's') {
  outputSTL();
  }
  
//  if (key == CODED) {
//    if (keyCode == UP) {
//      rotateX(-frameCount * 0.01);
//      print("up");
//    }
//    if (keyCode == DOWN) {
//      rotateX(frameCount * 0.01);
//      print("down");
//    }
//    if (keyCode == LEFT) {
//      rotateY(-frameCount * 0.01);
//      print("left");
//    }
//    if (keyCode == RIGHT){
//      rotateY(frameCount * 0.01);
//      print("right");
//    }
//  }
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

