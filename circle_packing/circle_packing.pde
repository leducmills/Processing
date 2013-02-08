import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;

import toxi.processing.*;

/*
  Circle packing demo using the algorithm described here:
 http://en.wiki.mcneel.com/default.aspx/McNeel/2DCirclePacking
 
 Sean McCullough
 banksean at gmail
 June 17, 2007
 */

//import noc.*;

ArrayList circles;
long iterationCounter = 0;

void setup() {
  size( 600, 600 );
  smooth();
  fill( 0 );
  frameRate( 20 );
  circles = createRandomCircles(50);
  background(255);
}

void draw() {
  background( 255 );
  for (int i=0; i<circles.size(); i++) {
    getCircle(i).draw();
  } 
  for (int i=1; i<50; i++) {
    iterateLayout(i);
  }
}

Comparator comp = new Comparator() {
    public int compare(Object p1, Object p2) {
      Circle a = (Circle)p1;
      Circle b = (Circle)p2;
      if (a.distanceToCenter() < b.distanceToCenter()) 
        return 1;
      else if (a.distanceToCenter() > b.distanceToCenter())
        return -1;
      else
        return 0;
    }
};

void iterateLayout(int iterationCounter) {

  Object circs[] = circles.toArray();
  Arrays.sort(circs, comp);

  //fix overlaps
  Circle ci, cj;
  Vec3D v = new Vec3D();

  for (int i=0; i<circs.length; i++) {
    ci = (Circle)circs[i];
    for (int j=i+1; j<circs.length; j++) {
      if (i != j) {
        cj = (Circle)circs[j];
        float dx = cj.x - ci.x;
        float dy = cj.y - ci.y;
        float r = ci.radius + cj.radius;
        float d = (dx*dx) + (dy*dy);
        if (d < (r * r) - 0.01 ) {

          v.x = dx;
          v.y = dy;

          v.normalize();
          
          //v = v*(r-sqrt(d))*0.5;
          v.scaleSelf((r-sqrt(d))*0.5);
          //v.mult((r-sqrt(d))*0.5);

          if (cj != dragCircle) {
            cj.x += v.x;
            cj.y += v.y;
          }

          if (ci != dragCircle) {     
            ci.x -= v.x;
            ci.y -= v.y;       
          }
        }
      }
    }
  }

  //Contract
  float damping = 0.1/(float)(iterationCounter);
  for (int i=0; i<circs.length; i++) {
    Circle c = (Circle)circs[i];
    if (c != dragCircle) {
      v.x = c.x-width/2;
      v.y = c.y-height/2;
      v.scaleSelf(damping);
      c.x -= v.x;
      c.y -= v.y;
    }
  }
}

ArrayList createRandomCircles(int n) {
  ArrayList circles = new ArrayList();
  colorMode(HSB, 255);
  while (n-- > 0) {
    Circle c = new Circle(random(width), random(height), random(n)+10);
    c.myColor = color(random(255), 128, 200, 128);
    circles.add(c);
  }
  colorMode(RGB,255);
  return circles;
}

Circle getCircle(int i) {
  return (Circle)circles.get(i);
}

Circle dragCircle = null;

void keyPressed() {
  circles = createRandomCircles(50);
}

void mousePressed() {
  dragCircle = null;
  for(int i=0; i<circles.size(); i++) {
    Circle c = getCircle(i);
    if (c.contains(mouseX, mouseY)) {
      dragCircle = c;
    }  
  }
}

void mouseDragged() {
  if (dragCircle != null) {
    dragCircle.x = mouseX;
    dragCircle.y = mouseY;
  }
}

void mouseReleased() {
  dragCircle = null;
}
