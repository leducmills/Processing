/* UCube v.07
 * 3d modeling input device and stl export
 * Manual rotation, shape mode toggle, and export button
 * by Ben Leduc-Mills
 */
import processing.opengl.*; 
import controlP5.*;
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import newhull.*;
//import quickhull3d.*;
import processing.serial.*;

Serial myPort; // the serial port
ControlP5 controlP5;
PFont myFont; //init font for text
STL stl; //init STL object
QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array
Point3d[] savedPoints;
//String coord[]; //coordinate array for drawing

float rotX, rotY;
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 50; //distance between points
int counter = 0;
String oldString;
boolean reDraw = true;

void setup() {
  size(750, 750, OPENGL);
  //smooth();
  //frameRate(60);
  // String[] fontList = PFont.list();
  // println(fontList);
  controlP5 = new ControlP5(this);
  controlP5.addButton("Export",0,100,100,150,30);
  controlP5.addButton("Mode", 0,100,131,150,30);
  myFont = createFont("FFScala", 32);
  textFont(myFont); 

  println(Serial.list()); // list available serial ports
  myPort = new Serial(this, Serial.list()[0], 19200);
  myPort.bufferUntil('\n');
  //background(255);  //set initial background color (just looks nicer on startup)
}

void draw() {
  //controlP5.draw();
}

void serialEvent(Serial myPort) {

  background(255);
  pushMatrix();
  translations();
  drawGrid();
  drawAxes();

  String inString = myPort.readStringUntil('\n');
  String m1[] = match(inString, "[0-3]");

  //TODO: compare inString to oldString to see if coords changed

  //if a coordinate string is coming in from arduino
  if (m1 != null) { 
    //if(inString != null) {  
    //make acive points more visible 
    strokeWeight(8);
    stroke(255, 0, 0); 

    if (inString != oldString) {
      reDraw = true;   
      oldString = inString;
    }
    
    inString = trim(inString);
    //split string of mutliple coordinates into coordinate-sized chuncks
    String coord[] = split(inString, ';');

    //init point3d array equal to number of activated points
    points = new Point3d[coord.length-1]; 

    //put the xyz coordinates into the point3d array and draw them
    for(int p3d = 0; p3d < coord.length-1; p3d++) {

      int subCoord[] = int(split(coord[p3d], ','));
      points[p3d] = new Point3d(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing);
      point(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing );
    }

    if (counter%2 != 0) {
      showShape();
    }
  } //end if inString!=null
  popMatrix();  
  controlP5.draw();
} //end draw

