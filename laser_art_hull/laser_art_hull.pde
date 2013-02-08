/* Laser Art Shapes
 * Using newhull and pdf export
 * by Ben Leduc-Mills
 */

import newhull.*;
import processing.pdf.*;

MHull h1, h2, h3, h4, h5, h6, h7, h8, h9, h10;
boolean doSave = false;
float rotX, rotY; //for manual roatation

public void setup() {

  size(1200, 600, P3D);
  smooth();
  background(255);
  noFill();
  // (numPoints, xMin, xMax, yMin, yMax, zMin, zMax, strokeWeight);
  h1 = new MHull(int(random(10)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 2);
  h2 = new MHull(int(random(20)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1);
  h3 = new MHull(int(random(30)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1.5);
  h4 = new MHull(int(random(40)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1);
  h5 = new MHull(int(random(50)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), .5);
  h6 = new MHull(int(random(40)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 2);
  h7 = new MHull(int(random(30)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1);
  h8 = new MHull(int(random(20)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1.5);
  h9 = new MHull(int(random(10)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), 1);
  h10 = new MHull(int(random(50)), int(random(-500)), int(random(500)), int(random(-200)), int(random(200)), int(random(-100)),int(random(500)), .5);
  
  h1.genPoints();
  h2.genPoints();
  h3.genPoints();
  h4.genPoints();
  h5.genPoints();
  h6.genPoints();
  h7.genPoints();
  h8.genPoints();
  h9.genPoints();
  h10.genPoints();
}

public void draw() {

  background(255);

  if (doSave) {
    PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput()); 
    // set default Illustrator stroke styles and paint background rect.
    pdf.strokeJoin(MITER);
    pdf.strokeCap(SQUARE);
    //pdf.fill(0);
    pdf.noStroke();
    pdf.rect(0,0, width,height);
  }

  pushMatrix();
  translations();
  h1.display();
  h2.display();
  h3.display();
  h4.display();
  h5.display();
  h6.display();
  h7.display();
  h8.display();
  h9.display();
  h10.display();
  popMatrix();
  if(doSave) {
    endRaw();
    doSave=false;
  }
}

class MHull {

  int numPoints;
  int xMax, xMin;
  int yMax, yMin;
  int zMax, zMin;
  float strokeW;
  Point3d[] points;
  QuickHull3D hull = new QuickHull3D();

  MHull(int inumPoints, int ixMin, int ixMax, int iyMin, int iyMax, int izMin, int izMax, float istrokeW) {

    numPoints = inumPoints;
    xMin = ixMin;
    xMax = ixMax;
    yMin = iyMin;
    yMax = iyMax;
    zMin = izMin;
    zMax = izMax;
    strokeW = istrokeW;
  }

  void genPoints() {

    points = new Point3d[numPoints];

    for (int i = 0; i < numPoints; i++) {

      int randX = int(random(xMin, xMax));
      int randY = int(random(yMin, yMax));
      int randZ = int(random(zMin, zMax));
      points[i] = new Point3d(randX, randY, randZ);
    }
  }

  void refresh() {

    genPoints();
  }

  void display() {

    if (hull.myCheck(points, numPoints) == true) {

      hull.build(points);
      //println("build");

      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = hull.getVertices();

      beginShape(TRIANGLE_STRIP);
      strokeWeight(strokeW);
      noFill(); 
      int[][] faceIndices = hull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
        }
      }
      endShape(CLOSE);
    }
 
  }
}


void mouseDragged() {
  float x1 = mouseX-pmouseX;
  float y1 = mouseY-pmouseY;
  rotX = (mouseY * -0.01);
  rotY = (mouseX * 0.01);
}

void translations() {  
  translate(width/2, height/2, -100);
  rotateX(rotX);
  rotateY(rotY);
}

void keyPressed() {
  if (key == 's') { 
    doSave=true;
  }
  if(key == '1') {
    h1.refresh();
  }
  if(key == '2') {
    h2.refresh();
  }
  if(key == '3') {
    h3.refresh();
  }
  if(key == '4') {
    h4.refresh();
  }
  if(key == '5') {
    h5.refresh();
  }
  if(key == '6') {
    h6.refresh();
  }
  if(key == '7') {
    h7.refresh();
  }
  if(key == '8') {
    h8.refresh();
  }
  if(key == '9') {
    h9.refresh();
  }
  if(key == '0') {
    h10.refresh();
  }
}

