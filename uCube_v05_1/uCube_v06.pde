/* UCube v.05
 * 3d modeling input device and stl export
 * Manual rotation, shape mode toggle, and export button
 * by Ben Leduc-Mills
 */
//import controlP5.*;
import guicomponents.*;
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;
import processing.serial.*;

Serial myPort; // the serial port
//ControlP5 controlP5;
GButton export, mode;
PFont myFont; //init font for text
STL stl; //init STL object
QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array

//String coord[]; //coordinate array for drawing

float rotX, rotY;
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 50; //distance between points
int counter = 0;

void setup() {
  size(1000, 750, P3D);
  //smooth();
  frameRate(30);
//  myFont = createFont("FFScala", 32);
//  textFont(myFont); 
  // String[] fontList = PFont.list();
  // println(fontList);
  // controlP5 = new ControlP5(this);
  // controlP5.addButton("Export",0,100,100,150,30);
  // controlP5.addButton("Mode", 0,100,131,150,30);
  G4P.setColorScheme(this, GCScheme.BLUE_SCHEME);
  G4P.setFont(this, "FFScala", 12);
  
  export = new GButton(this,"Export", 10, 100, 100, 20);
  mode = new GButton(this, "Mode", 10, 120, 100, 20);
  export.fireAllEvents(true);
  mode.fireAllEvents(true);
  G4P.setMouseOverEnabled(true);

  println(Serial.list()); // list available serial ports
  myPort = new Serial(this, Serial.list()[0], 9600);
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

  if (inString != null) {

    //make acive points more visible 
    strokeWeight(8);
    stroke(255, 0, 0); 

    //trim whitespace
    inString = trim(inString);
    //  println(inString);

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
  //controlP5.draw();
} //end draw

