// modelab.nu Processing Tutorial - Marius Watz, 2010
// http://modelab.nu/?p=4147 / http://workshop.evolutionzone.com
//
// Shared under Creative Commons "share-alike non-commercial use 
// only" license.
// 
// Processing does not have any built-in mechanism for building 
// and manipulating 3D models as logical objects, it only provides
// the OpenGL-like commands for drawing them. To deal with objects
// more like scene graphs we need to use external libraries, for
// instant the excellent Toxiclibs library from Karsten Schmidt.
//
// This example shows how to build a mesh with toxiclibs and
// save it out as a binary STL file ready for 3D printing.

import controlP5.*;
import processing.opengl.*;
import java.awt.event.*;

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

ControlP5 controlP5; // instance of the controlP5 library
Nav3D nav; // camera controller

GeomObj[] geom;
ToxiclibsSupport gfx; // toxiclibs utility class
TriangleMesh worldSphere;

void setup() {
  size(600,600, OPENGL);
  gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport

  initControllers(); // initialize interface, see "GUI" tab
  generateMesh(); // initialize mesh surface, see "Terrain"
  
  // create a mesh of a sphere with radius 60
  worldSphere=(TriangleMesh)new Sphere(60).toMesh(36);
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

  nav.transform(); // do transformations using Nav3D controller

  // draw our meshes to screen
  for(int i=0; i<geom.length; i++) geom[i].draw();

  // draw center sphere
  fill(100);
  gfx.mesh(worldSphere);
  
  popMatrix();  

  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);
}

// initializes 3D mesh. called by the "generatemesh" bang
void generateMesh() {
  // create new array of GeomObj with random size
  geom=new GeomObj[int(random(50,500))];
  for(int i=0; i<geom.length; i++) {
    geom[i]=new GeomObj();
  }
}

// saves objects to STL file. called by the "savefile" bang
void saveFile() {
  TriangleMesh myWorld=new TriangleMesh();

  // to save the objects to STL we first need to collect them
  // in a single TriangleMesh, using TriangleMesh.addMesh()
  myWorld.addMesh(worldSphere);
  for(int i=0; i<geom.length; i++) {
    myWorld.addMesh(geom[i].mesh);
  }

  // save myWorld to a STL file
  myWorld.saveAsSTL(sketchPath("GeomObj.stl"));
  println("Saved 'GeomObj.stl' to file, "+geom.length+" objects.");
}

