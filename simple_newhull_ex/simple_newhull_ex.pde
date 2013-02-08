import processing.opengl.*;

/* Simple NewHull Library Example
 * by Ben Leduc-Mills
 * 2.02.11
 */

import newhull.*;

QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array

void setup() {

  size(200,200,OPENGL);
  background(255); 

  //point array
  points = new Point3d[] { 
    new Point3d (0.0,  0.0,  0.0),
    new Point3d (0.0,  0.0,  50.0),
    new Point3d (0.0,  50.0,  0.0),
    new Point3d (0.0,  50.0,  50.0),
    new Point3d (50.0,  0.0,  0.0),
    new Point3d (50.0,  0.0,  50.0),
    new Point3d (50.0,  50.0,  50.0),
    new Point3d (50.0,  50.0,  0.0),
  };
}  

void draw() {
  background(255);
  smooth(); 
  translate(width/2, height/2);
  rotateY(frameCount * 0.01); 

  int numPoints = points.length; 

  //check that our hull is valid
  if (hull.myCheck(points, numPoints) == true) {

    hull.build(points);  //build hull
    hull.triangulate();  //triangulate faces
    Point3d[] vertices = hull.getVertices();  //get vertices

    beginShape(TRIANGLE_STRIP);
    int[][] faceIndices = hull.getFaces();
    //run through faces (each point on each face), and draw them
    for (int i = 0; i < faceIndices.length; i++) {  
      for (int k = 0; k < faceIndices[i].length; k++) {
        //println(faceIndices[i][k] + " ");
        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
        println(x + "," + y + "," + z);
      }
    }
    endShape(CLOSE);
  }
}

