/* Simple NewHull Library Example
 * by Ben Leduc-Mills
 * 2.02.11
 */
import processing.opengl.*;
import newhull.*;
import java.awt.event.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array
Point3d[] savedPoints;

ToxiclibsSupport gfx;
Mesh3D mesh = new TriangleMesh();
Vec3D[] vectors = new Vec3D[0];
boolean reDraw = true;

void setup() {

  size(200,200,OPENGL);
  gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport
  background(255); 

  //point array (cube)
//  points = new Point3d[] { 
//    new Point3d (0.0,  0.0,  0.0),
//    new Point3d (0.0,  0.0,  50.0),
//    new Point3d (0.0,  50.0,  0.0),
//    new Point3d (0.0,  50.0,  50.0),
//    new Point3d (50.0,  0.0,  0.0),
//    new Point3d (50.0,  0.0,  50.0),
//    new Point3d (50.0,  50.0,  50.0),
//    new Point3d (50.0,  50.0,  0.0),
//  };

//tri prism
points = new Point3d[] {
 
  new Point3d(0.0, 0.0, 0.0),
  new Point3d(20.0, 0.0, 0.0),
  new Point3d(0.0, 20.0, 0.0),
  new Point3d(20.0, 20.0, 0.0),
  new Point3d(20.0, 10.0, 10.0),
  new Point3d(0.0, 10.0, 10.0),
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


    if(reDraw == true) {
      //print("redraw = true");
      hull.build(points);
      hull.triangulate();
      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = hull.getVertices();
      savedPoints = new Point3d[0];

      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      //noFill(); 
      int[][] faceIndices = hull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
          Vec3D tempVect = new Vec3D(x,y,z);
          println(x + "," + y + "," + z + " " + k);
          savedPoints = (Point3d[])append(savedPoints, pnt2);
          vectors = (Vec3D[])append(vectors, tempVect);
          //savedPoints[k] = new Point3d(pnt2);
          //println(savedPoints[k]);

          //println(x + "," + y + "," + z);
        }
      }
      endShape(CLOSE);
      reDraw = false;
    }

    else if(reDraw == false) {
      // print("redraw = false");
      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      //noFill(); 
      for(int i = 0; i < savedPoints.length; i++) {

        float x = (float)savedPoints[i].x;
        float y = (float)savedPoints[i].y;
        float z = (float)savedPoints[i].z;
        vertex(x,y,z);
      }
      endShape(CLOSE);
    }
  }
}


void keyPressed() {

  if(keyCode == 'P') {

    for(int i = 0; i < vectors.length; i++) {

      println("vectors" + " " + vectors[i]);
    }
  }

  if(keyCode == 'S') {

    outputSTL();
  }
}


void outputSTL() {
  
  TriangleMesh mySTL = new TriangleMesh();


  for(int i = 0; i < vectors.length; i+=3) {

    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
    println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }
  
  mySTL.addMesh(mesh);
  
  mySTL.saveAsSTL(selectOutput());

  // int faces = mesh.getNumFaces();
  // println(faces);
}

