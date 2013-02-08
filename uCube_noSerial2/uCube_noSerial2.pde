/* UCube v.0x2
 * 3d modeling input device and stl export
 * No Serial communication, used for software feature building
 * by Ben Leduc-Mills
 */
import controlP5.*;
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import newhull.*;
//import quickhull3d.*;
//import processing.serial.*;

//Serial myPort; // the serial port
ControlP5 controlP5; 
PFont myFont; //init font for text
STL stl; //init STL object
FaceList poly; //FaceList object for .stl import
QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array

float rotX, rotY; //for manual roatation
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 50; //distance between points
int counter = 0; //wireframe toggle
String inString; //string of coordinates from arduino
String oldString;
boolean reDraw = true;
Point3d[] savedPoints;

void setup() {
  // String[] fontList = PFont.list();
  // println(fontList);
  controlP5 = new ControlP5(this);
  controlP5.addButton("Refresh",0,100,100,80,19);
  controlP5.addButton("Mode", 0,100,120,80,19);
  controlP5.addButton("Export", 0,100,140,80,19);
  controlP5.addButton("Import", 0,100,160,80,19);
  myFont = createFont("FFScala", 32);
  textFont(myFont);
  //println(hull.myCheck());
  size(1000, 750, P3D);
  // println(Serial.list()); // list available serial ports
  // myPort = new Serial(this, Serial.list()[0], 9600);
  // myPort.bufferUntil('\n');
  background(255);  //set initial background color (just looks nicer on startup)
  //genPoints(); //generate random set of points
}

void draw() {

  background(250);

  pushMatrix();

  translations();
  drawGrid();
  drawAxes();

  //inString = "0,0,0;0,0,2;0,2,0;0,2,2;2,0,0;2,0,2;2,2,2;2,2,0;"; //cube
  //inString = "0,0,0;0,1,0;0,2,0;0,3,0;"; //straight line
  //inString = "0,0,0;1,1,1;2,2,2;3,3,3;1,2,3;"; //diagonal line
  inString = "0,0,0;2,0,0;0,2,0;2,2,0;2,1,1;0,1,1;"; //tetrahedron (kinda)


  if (poly != null) {
    drawImport();
    //poly.draw(this);
  }

  if (inString != null) {

    //make acive points more visible 
    strokeWeight(8);
    stroke(255, 0, 0); 

    if (inString != oldString) {
      reDraw = true;   
      oldString = inString;
      
    }
    //reDraw = false;
    inString = trim(inString);

    //split string of mutliple coordinates into coordinate-sized chuncks
    String coord[] = split(inString, ';');

    //init point3d array equal to number of activated points
    points = new Point3d[coord.length-1]; 

    //put the xyz coordinates into the point3d array and draw them
    for(int p3d = 0; p3d < coord.length-1; p3d++) {

      int subCoord[] = int(split(coord[p3d], ','));
      points[p3d] = new Point3d(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing);
      point(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing);
    }    

    if (counter%2 != 0) {
      showShape();
    }
  }//end if inString!=null
  popMatrix();
} //end draw

