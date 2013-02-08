// modelab.nu Processing Tutorial - Marius Watz, 2010
// http://modelab.nu/?p=4147 / http://workshop.evolutionzone.com
//
// Shared under Creative Commons "share-alike non-commercial use 
// only" license.
// 
// To generate 3D mesh objects we use the beginShape(), vertex()
// and endShape() commands. 

import controlP5.*;
import processing.opengl.*;

ControlP5 controlP5; // instance of the controlP5 library

// variables that will be mapped to sliders
float slW,slH,slCylRes; 

float rotX,rotY;

void setup() {
  size(400,400, OPENGL);
  smooth();
  
  initControllers(); // set up GUI  
  cylinderDetail((int)slCylRes); // generate cylinder data
}

void draw() {
  background(255);

  // because we want controlP5 to be drawn on top of everything
  // else we need to disable OpenGL's depth testing at the end
  // of draw(). that means we need to turn it on again here.
  hint(ENABLE_DEPTH_TEST); 

  pushMatrix();
  translate(width/2,height/2);
  lights();
  
  // rotate camera view
  rotateY(rotY);
  rotateX(rotX);
  
  fill(255,160,0);
  stroke(0);
  
  if(cylNum!=(int)slCylRes) cylinderDetail((int)slCylRes);
  // call our custom cylinder() function
  cylinder(slW,slH);
  
  popMatrix();
  
  // turn off depth test so the controlP5 GUI draws correctly.
  // controlP5 automatically draws itself after draw() is done.
  hint(DISABLE_DEPTH_TEST);

}

// calculate rotations from mouse position
void mouseDragged() {
  // ignore mouse event if cursor is over controlP5 GUI elements
  if(controlP5.window(this).isMouseOver()) return;
  
  // we can use the map() function to map values from one
  // number range to another. let's use it to map mouseX and
  // mouseY into values from 0..PI, so that we can use the
  // mouse position to rotate the view
  
  rotX=map(mouseY, // input value
    0,200, // min and max range of input value
    0,PI); // min and max range of output value

  rotY=map(mouseX, // input value
    0,200, // min and max range of input value
    0,PI); // min and max range of output value
}

