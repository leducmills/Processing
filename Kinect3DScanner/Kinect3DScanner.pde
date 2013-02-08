//From Making things See, code by Greg Borenstein

import java.text.SimpleDateFormat;
import java.util.Date;

import processing.core.PApplet;
import processing.core.PVector;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;
import SimpleOpenNI.*;

SimpleOpenNI kinect;

boolean scanning = false;
int maxZ = 2000;
int spacing = 3;

UGeometry model;
UVertexList vertexList;

public void setup() {

  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  model = new UGeometry();
  vertexList = new UVertexList();
}

public void draw() {

  background(0);

  kinect.update();

  translate(width/2, height/2, -1000);
  rotateX(radians(180));  

  if (scanning) {
    model.beginShape(TRIANGLES);
  }

  PVector[] depthPoints = kinect.depthMapRealWorld();


  //cleanup pass
  for (int y = 0; y <480; y+= spacing) {
    for (int x = 0; x< 640; x+= spacing) {

      int i = y * 640 + x;
      PVector p = depthPoints[i];

      //if point is on edge or has no depth
      if (p.z < 10 || p.z > maxZ || y == 0 || y == 480 - spacing || x == 0 || x == 640 - spacing) {

        //replace with point at depth of backplane (maxZ)
        PVector realWorld = new PVector();
        PVector projective = new PVector(x, y, maxZ);

        kinect.convertProjectiveToRealWorld(projective, realWorld);

        depthPoints[i] = realWorld;
      }
    }
  }


  for (int y = 0; y <480 -spacing; y+=spacing) {
    for (int x = 0; x <640 - spacing; x += spacing) {

      if (scanning) {

        int nw = x + y * 640;
        int ne = (x + spacing) + y * 640;
        int sw = x + (y+spacing) * 640;
        int se = (x + spacing) + (y + spacing) * 640;

        model.addFace(new UVec3(depthPoints[nw].x, depthPoints[nw].y, depthPoints[nw].z), 
        new UVec3(depthPoints[ne].x, depthPoints[ne].y, depthPoints[ne].z), 
        new UVec3(depthPoints[sw].x, depthPoints[sw].y, depthPoints[sw].z));

        model.addFace(new UVec3(depthPoints[ne].x, depthPoints[ne].y, depthPoints[ne].z), 
        new UVec3(depthPoints[se].x, depthPoints[se].y, depthPoints[se].z), 
        new UVec3(depthPoints[sw].x, depthPoints[sw].y, depthPoints[sw].z));
      }
      else {
        stroke(255);
        int i = y * 640 + x;
        PVector currentPoint = depthPoints[i];

        if (currentPoint.z < maxZ) {
          point(currentPoint.x, currentPoint.y, currentPoint.z);
        }
      }
    }
  }

  if (scanning) {


    model.calcBounds();
    model.translate(0, 0, -maxZ);

    float modelWidth = (model.bb.max.x - model.bb.min.x);
    float modelHeight = (model.bb.max.y -model.bb.min.y);

    UGeometry backing = Primitive.box(modelWidth/2, modelHeight/2, 10);
    model.add(backing);

    model.scale((float) 0.01);

    model.rotateY(radians(180));
    model.toOrigin();

    model.endShape();

    SimpleDateFormat logFileFmt = new SimpleDateFormat("'scan_'yyyyMMddHHmmss'.stl'");
    model.writeSTL(this, logFileFmt.format(new Date()));

    model.writeSTL(this, "scan_"+random(1000)+".stl");
    scanning = false;
  }
}

public void keyPressed() {
  println(maxZ);
  if (keyCode == UP) {
    maxZ += 100;
  }
  if (keyCode == DOWN) {
    maxZ -= 100;
  }
  if (key == ' ') {
    scanning = true;
    model.reset();
  }
}

