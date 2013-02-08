// modelab.nu Processing Tutorial - Marius Watz, 2010
// http://modelab.nu/?p=4147 / http://workshop.evolutionzone.com
//
// Shared under Creative Commons "share-alike non-commercial use 
// only" license.
// 
// Processing doesn't have any built-in GUI features, requiring
// the user to build their own using event handler functions like
// mousePressed() and keyPressed(). Fortunately Andreas Schlegel
// has written an excellent GUI library called controlP5. 
// http://www.sojamo.de/libraries/controlP5/
//
// This example shows how to use basic controlP5 functionality.
// For more complex examples see the examples in the folder
// "libraries/controlP5/examples".

import controlP5.*;

ControlP5 controlP5; // instance of the controlP5 library

// variables that will be mapped to sliders
float slColor,slSize; 
boolean toggleShape;

void setup() {
  size(400,400);
  smooth();
  
  // initialize an instance of ControlP5
  controlP5 = new ControlP5(this);
  
  // we are using a white background, so set the color of
  // text labels to black
  controlP5.setColorLabel(color(0,0,0));
    
  slColor=150;
  controlP5.addSlider("slColor", // name, must match variable name
    50,255, // min and max values
    slColor, // the default value
    20,20, // X,Y position of slider
    100,13); // width and height of slider

  slSize=100;
  controlP5.addSlider("slSize", // name, must match variable name
    10,width, // min and max values
    slSize, // the default value
    20,35, // X,Y position of slider
    100,13); // width and height of slider
  
  // add toggle switch
  controlP5.addToggle("toggleShape",
    20,50, // X,Y position
    20,20); // width and height
}

void draw() {
  background(255);

  // the value of variables slColor and slSize are automatically
  // mapped to the value of the sliders of the same name.
  // slColor is used to control color.
  // slSize is used to control size of the object.
  
  pushMatrix();
  translate(width/2,height/2);
  
  // check toggleShape to see if we should draw circle or square
  if(toggleShape) {
    noFill();
    stroke(0,slColor,255);
    strokeWeight(5);
    rect(-slSize/2,-slSize/2, slSize,slSize);
    noStroke();
    fill(0,slColor,255);
    rect(-slSize/4,-slSize/4, slSize/2,slSize/2);
  }
  else {
    noStroke();
    fill(255,slColor,0);
    ellipse(0,0, slSize,slSize);
    fill(255);
    ellipse(0,0, slSize/2,slSize/2);
  }
  
  popMatrix();
}

