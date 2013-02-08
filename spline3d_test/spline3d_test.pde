import processing.opengl.*;
import toxi.geom.*;


int numPoints = 100;
Vec3D[] points = new Vec3D[0];


void setup() {
  size(400,400,OPENGL);
  smooth();

  for(int i = 0; i < numPoints; i++) {

    float x = random(50,150);
    float y = random(51,150);
    float z = random(51,150);

    Vec3D temp = new Vec3D(x,y,z);

    points = (Vec3D[])append(points, temp);
  }
}



void draw() {
  background(255);
  noFill();
  stroke(0);

  if(numPoints > 3) {

    Spline3D spline = new Spline3D(points);
    java.util.List vertices = spline.computeVertices(8);

    beginShape();
    for(Iterator i=vertices.iterator(); i.hasNext(); ) {
      Vec3D v=(Vec3D)i.next();
      vertex(v.x,v.y,v.z);
    }
    endShape();
  }
}

