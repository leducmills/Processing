/* UCube v.09
 * 3d modeling input device and stl export 
 * now using toxiclibs and opengl, lights, camera, keyboard movement control
 * Manual rotation, shape mode toggle, and export button
 * by Ben Leduc-Mills - 3.28.11
 */

import processing.opengl.*;
import newhull.*;
//import java.awt.event.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import controlP5.*;
import processing.serial.*;

//import javax.media.opengl.GL;

ControlP5 controlP5;
Nav3D nav; // camera controller

QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array
Point3d[] savedPoints;

//ToxiclibsSupport gfx;
Mesh3D mesh = new TriangleMesh();
Vec3D[] vectors;

Serial myPort; // the serial port

float rotX, rotY; //for manual roatation
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 70; //distance between points
int counter = 0; //wireframe toggle
String inString; //string of coordinates from arduino
String oldString;
boolean reDraw = true;
boolean doFill = true;
boolean doGrid = true;
PFont myFont; //init font for text


void setup() {

  size(1400,850,OPENGL);
  frameRate(10);
  //gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport
  background(255);
  initControllers(); //init interface, see GUI tab 

  myFont = createFont("FFScala", 32);
  textFont(myFont);

  println(Serial.list()); // list available serial ports
  myPort = new Serial(this, Serial.list()[0], 19200);
  myPort.clear();
  
} 

void draw() {

  //void serialEvent(Serial myPort) {

  background(255);
  //smooth();
  // because we want controlP5 to be drawn on top of everything
  // else we need to disable OpenGL's depth testing at the end
  // of draw(). that means we need to turn it on again here.
  hint(ENABLE_DEPTH_TEST);

  pushMatrix();
  lights();
  nav.transform(); // do tranformations using Nav3D controller
  //drawGrid();

  if (doGrid == true) {
    drawGrid();
  }

  drawAxes();

  while (myPort.available() > 1) {
    
    myPort.bufferUntil('\n');
    String inString = myPort.readStringUntil('\n');
    //String m1[] = match(inString, "[0-3]");
    

    //TODO: compare inString to oldString to see if coords changed

    //if a coordinate string is coming in from arduino
    if (inString != null) { 

      //make acive points more visible 
      strokeWeight(8);
      stroke(255, 0, 0); 

      if (inString != oldString) {
        reDraw = true;   
        oldString = inString;
        print(inString);
      }

      inString = trim(inString);
      //split string of mutliple coordinates into coordinate-sized chuncks
      String coord[] = split(inString, ';');

      //init point3d array equal to number of activated points
      points = new Point3d[coord.length-1]; 

      //put the xyz coordinates into the point3d array and draw them
      for(int p3d = 0; p3d < coord.length-1; p3d++) {

        int subCoord[] = int(split(coord[p3d], ','));
        points[p3d] = new Point3d(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing);
        point(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing );
      }
    }
  }
    if (counter%2 != 0) {
      drawHull();
    }
   //end if inString!=null
  popMatrix();  
  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);
}

