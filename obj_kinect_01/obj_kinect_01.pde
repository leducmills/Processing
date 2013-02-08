/* Model Home v1
 * Obj manipulation with kinect
 * Nick O'Brien & Ben Leduc-Mills
 * Kinect lib from Dan Shiffman
 * 1.21.11
 */

import org.openkinect.*;
import org.openkinect.processing.*;
import saito.objloader.*;

KinectTracker tracker;
Kinect kinect;

OBJModel model;
OBJModel tmpmodel;

PVector v1;

void setup() {
  //size(640,480,P3D);
  size(1280,480,P3D);
  model = new OBJModel(this);
  tmpmodel = new OBJModel(this);
  model.enableDebug();
  model.load("house_obj.obj");
  tmpmodel.load("house_obj.obj");
  stroke(200);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
}

void draw() {
  background(0);
  //rotateY(frameCount*0.01);
  pushMatrix();
  //translate(width/4, height/2, 0);

  tracker.track();
  tracker.display();


  //  fill(50,100,250,200);
  //  noStroke();
  //  ellipse(v1.x,v1.y,20,20);

  // Let's draw the "lerped" location
  //  PVector v2 = tracker.getLerpedPos();
  //  fill(100,250,50,200);
  //  noStroke();
  //  ellipse(v2.x,v2.y,20,20);

  v1 = tracker.getPos();
  scale(v1.x/2, v1.y/2, 20);
  tmpmodel.draw();
  //animation();

  // tmpmodel.draw();
  //model.draw();
  popMatrix();
}

void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}
float k = 0.0;
void animation() {

  for(int i = 0; i < model.getVertexCount(); i++) {
    PVector orgv = model.getVertex(i);
    //    PVector tmpv = new PVector();
    //    tmpv.x = orgv.x * (abs(sin(k+i*0.04)) * 0.3 + 1.0);
    //    tmpv.y = orgv.y * (abs(cos(k+i*0.04)) * 0.3 + 1.0);
    //    tmpv.z = orgv.z * (abs(cos(k/5.)) * 0.3 + 1.0);
    PVector tmpv = new PVector();
    tmpv.x = orgv.x + 320;
    tmpv.y = orgv.y + 240;
    tmpv.z = orgv.z;
    tmpmodel.setVertex(i, tmpv);
  }
  k+=0.1;
}

void stop() {
  tracker.quit();
  super.stop();
}

