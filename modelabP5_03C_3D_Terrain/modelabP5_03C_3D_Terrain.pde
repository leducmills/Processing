// modelab.nu Processing Tutorial - Marius Watz, 2010
// http://modelab.nu/?p=4147 / http://workshop.evolutionzone.com
//
// Shared under Creative Commons "share-alike non-commercial use 
// only" license.
// 
// Example showing how to generate a 3D terrain with noise(x,y) 
// and rendering it as a mesh with begin/endShape(). We use 
// controlP5 to let the user control the resolution of the mesh
// as well as the behavior of the 2D noise. The "GenerateMesh"
// button creates a new random mesh.
//
// We've also added a Nav3D class which takes care of standard
// 3D viewing controls, allowing rotating by dragging the mouse,
// panning with shift-click and zoom with the mouse wheel.

import controlP5.*;
import processing.opengl.*;
import java.awt.event.*;

ControlP5 controlP5; // instance of the controlP5 library

float slGridResolution; // slider value for grid resolution
float Z; // controls the height difference in the terrain
float noiseXD,noiseYD; // modifiers for X,Y noise
boolean toggleSolid=true; // controls rendering style

Nav3D nav; // camera controller
Terrain terrain; // Terrain object

void setup() {
  size(600,600, OPENGL);
  
  initControllers(); // initialize interface, see "GUI" tab
  generateMesh(); // initialize mesh surface, see "Terrain"
}

void draw() {
  background(255);
  smooth();

  // because we want controlP5 to be drawn on top of everything
  // else we need to disable OpenGL's depth testing at the end
  // of draw(). that means we need to turn it on again here.
  hint(ENABLE_DEPTH_TEST); 
  
  pushMatrix();    
  lights();
    
  nav.transform(); // transformations using Nav3D
  terrain.draw();
  
  popMatrix();
  
  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);
}

// initializes 3D mesh
void generateMesh() {
  terrain=new Terrain();
}
