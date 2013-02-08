/* Model Home v2
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
PVector v2;
PImage a = loadImage("/Users/ben/Documents/Processing/obj_kinect_02/data/Grass0033_2_thumbhuge.jpg");
PImage b = loadImage("/Users/ben/Documents/Processing/obj_kinect_02/data/lava_rock_texture_04.jpg");
PImage c = loadImage("/Users/ben/Documents/Processing/obj_kinect_02/data/stone_A220535.jpg");
PImage d = loadImage("/Users/ben/Documents/Processing/obj_kinect_02/data/patterned_stone_C050573.jpg");
float rotX, rotY; //for rotation


long resetDelay = 1000;
long lastReset = 1;


void setup() {
  size(640,480,P3D);
  //size(1280,480,P3D);
  model = new OBJModel(this);
  tmpmodel = new OBJModel(this);
  model.enableDebug();
  model.load("house_obj._test.obj");
  tmpmodel.load("house_obj._test.obj");
//  model.load("house_obj.obj");
//  tmpmodel.load("house_obj.obj");
  stroke(200);
  


  
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
}

void draw() {
  background(0);
  //rotateY(frameCount*0.01);
  
  pushMatrix();
  translate(width/2, height/2, 0);
  //rotation();
  tracker.track();
  tracker.display();
  transform();

  //  fill(50,100,250,200);
  //  noStroke();
  //  ellipse(v1.x,v1.y,20,20);

  // Let's draw the "lerped" location
  v2 = tracker.getLerpedPos();
  //v2 = tracker.getPos();
  v2.x = v2.x - 100;
  v2.y = v2.y - 100;
  fill(100,250,50,200);
  //noStroke();
  ellipse(v2.x,v2.y,20,20);

  v1 = tracker.getPos();
  scale(100,100,100);
  //scale(v1.x/3, v1.y/3, 20);
  tmpmodel.draw();
  //println(v2.x + " " + v2.y);
  
  //model.draw();
  popMatrix();
  animation();
  
 
  if (millis() > resetDelay * lastReset ) {
   println("reset");
   lastReset += 1;
   reset();
  } 
  
  
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
    
    else if (keyCode == 't') {
     tmpmodel.disableTexture(); 
     println('t');
    }
  }
}


void reset() {
// for(int i = 0; i < model.getVertexCount(); i++) {
//    PVector orgv = model.getVertex(i);
//    PVector tmpv = new PVector();
//    tmpv.x = orgv.x;
//    tmpv.y = orgv.y; 
//    tmpv.z = orgv.z;
//    tmpmodel.setVertex(i, tmpv);
// }
  //model.clear();
  tmpmodel.reset();
  tmpmodel.load("house_obj._test.obj");
  
}


void stop() {
  tracker.quit();
  super.stop();
}

