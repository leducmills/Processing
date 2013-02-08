

import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;

Shape_obj thing;

void setup() {
  size(640,480,P3D);
  thing = new Shape_obj(int(random(500)),int(random(500)),int(random(500)),int(random(200)),int(random(200)));
  thing.makeShape();
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableRGB(true);
}

void draw() {
  background(0);
  rotateY(frameCount*0.01);
  thing.display();
  translate(width+50,height+50,-50);
  PImage img = kinect.getVideoImage();
  image(img,0,0);
}


class Shape_obj {
  //pass variable to call later
  int h;
  int w;
  int z;
  int xpos;
  int ypos;
  int numPoints = 10;
  int[] points = new int[numPoints * 3];

  //constrcution of variables
  Shape_obj(int h1, int w1, int z1, int xpos1, int ypos1) {
    h = h1;
    w = w1;
    z = z1;
    xpos = xpos1;
    ypos = ypos1;
  }

  //display the variables

  void display() {
    translate(xpos, ypos, 0);
    beginShape();
    for (int i = 0; i < points.length; i+=3) {
      vertex(points[i], points[i+1], points[i+2]);
      println(points[i] + "," + points[i+1] + "," + points[i+2]); 
    }
    endShape(CLOSE);
  }

  //draw only once

  void makeShape() { 
    
    for (int i = 0; i < points.length; i+=3) {
      points[i] = int(random(50,h));
      points[i+1] = int(random(50,w));
      points[i+2] = int(random(z));
    }
    
  }
}

void stop() {
  kinect.quit();
  super.stop();
}

