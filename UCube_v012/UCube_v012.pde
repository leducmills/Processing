import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

/* UCube v.12
 * 3d modeling input device and stl export 
 * now using toxiclibs and opengl, lights, camera, keyboard movement control
 * Manual rotation, shape mode toggle, and export button
 * Added serial handshake
 * Adding Edit Mode
 * by Ben Leduc-Mills - 3.05.12
 */

import processing.opengl.*;
import newhull.*;
//import java.awt.event.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import controlP5.*;
import processing.serial.*;

import java.util.Collection;

UGeometry model;
UGeometry model2;

//import javax.media.opengl.GL;
String version = "UCube v.012";
ControlP5 controlP5;
Nav3D nav; // camera controller

QuickHull3D hull = new QuickHull3D(); //init quickhull for hull
QuickHull3D knotHull = new QuickHull3D(); //init quickhull for knot
Point3d[] points; //init Point3d array
Point3d[] savedPoints;

ToxiclibsSupport gfx;
Mesh3D mesh = new TriangleMesh(); //triangle mesh for convex hull
Mesh3D knotMesh = new TriangleMesh(); //trianglemesh for knot
Vec3D[] vectors;
Vec3D[] sVectors; //spline vectors
Vec2D[] mouseOverVectors; //for keeping track of mouseover

ArrayList<Vec3D> knotVectors = new ArrayList<Vec3D>(); //array list of vectors for knot making
Vec3D[] kVectors = new Vec3D[0]; //collection of all knot vectors
Point3d[] knotPoints = new Point3d[0]; //knot points (cubes around each point)
Point3d[] kSavedPoints = new Point3d[0];//saved points for knot
int offset = 10; //how thick your knot is

Serial myPort; // the serial port
boolean firstContact = false; // Whether we've heard from the microcontroller

float rotX, rotY; //for manual roatation
float x, y; //for hitdetection screenX and screenY positions
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 70; //distance between points
int counter = 0; //wireframe toggle
String inString; //string of coordinates from arduino
String oldString;
String message; // for UI hints
boolean reDraw = true;
boolean reDrawKnot = true;
boolean doFill = true;
boolean doGrid = true;
boolean doSpline = false;
boolean mouseOver = false;
boolean doHull = false;
boolean doKnot = false;
int vertexMouseOver = -1;
PFont myFont; //init font for text
PrintWriter output; //for saving shape
BufferedReader reader; // for loading shapes



boolean readSerial = true;
//String inString;


void setup() {
  model = new UGeometry();
  model2 = new UGeometry();

  size(1450, 850, OPENGL);
  frameRate(20);
  gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport
  background(255);
  initControllers(); //init interface, see GUI tab
  mouseOverVectors = new Vec2D[0]; 

  myFont = createFont("FFScala", 32);
  textFont(myFont);

  println(Serial.list()); // list available serial ports
  myPort = new Serial(this, Serial.list()[0], 19200);
  myPort.clear();
} 

void draw() {

  //void serialEvent(Serial myPort) {

  background(255);
  smooth();
  // because we want controlP5 to be drawn on top of everything
  // else we need to disable OpenGL's depth testing at the end
  // of draw(). that means we need to turn it on again here.
  hint(ENABLE_DEPTH_TEST);
  pushMatrix();
  lights();
  nav.transform(); // do tranformations using Nav3D controller
  //drawGrid();

  if (doGrid == true) {
    drawGrid(); //draw grid
  }

  if (doSpline == true) {
    drawSpline(); //do splines
  }



  drawAxes(); //draw axes

  //we have a serial connection
  while (myPort.available() > 1) { 

    //myPort.bufferUntil('\n');
    inString = myPort.readStringUntil('\n');

    //println(inString);
    //String m1[] = match(inString, "[0-3]");
    //inString = "0,0,0;2,0,0;0,2,0;2,2,0;2,1,1;0,1,1;"; //tetrahedron (kinda)
    //inString = "0,0,0;";
    
    //if a coordinate string is coming in from arduino
    if (inString != null) {

      inString = trim(inString);
      //println(inString); 

      //if this is our first contact with the arduino
      if (firstContact == false) {
        //if we get a hello, clear the port, set firstconatct to false, send back an 'A', and print 'contact'
        if (inString.equals("hello")) {
          myPort.clear();
          firstContact = true;
          myPort.write('A');
          println("contact");
        }
      }
      else {
        //make acive points more visible 
        strokeWeight(8);
        stroke(255, 0, 0);

        //compare inString to oldString to see if coords changed
        if (inString.equals(oldString)) {
          //do nothing
        }
        else {
          //if we're not in edit mode, update the input coordinates and redraw the hull
          if (readSerial == true) {
            oldString = inString;
            println(inString); 
            reDraw = true;
          }
          //if we are in edit mode, freeze the set of coordinates so we can edit
          if (readSerial == false) {
            inString = oldString;
          }
          
          //trim whitespace
          inString = trim(inString);
          
          //split string of mutliple coordinates into coordinate-sized chuncks
          String coord[] = split(inString, ';');

          //init point3d and vectors arrays equal to number of activated points
          points = new Point3d[coord.length-1]; 
          vectors = new Vec3D[coord.length];

          //put the xyz coordinates into the point3d array and the vector3D and draw them
          for (int i = 0; i < coord.length-1; i++) {

            float subCoord[] = float(split(coord[i], ','));
            points[i] = new Point3d(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing);
            vectors[i] = new Vec3D(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing);

            //only add unseen points to the knotVectors array (bad way of doing path / sequence)
            if (knotVectors.contains(vectors[i])) {
            }
            else {
              knotVectors.add(vectors[i]);
              println(vectors[i] + " true");
              reDrawKnot = true;
            }
          }
        }

        if (vectors.length > 0) {
          //put points on the canvas
          for (int j = 0; j < vectors.length-1; j++) {
            //println(vectors[j]); 
            float x = vectors[j].x;
            float y = vectors[j].y;
            float z = vectors[j].z;
            point(x, y, z);
          }
        }

        //call drawHull function if Hull button is 
        if (doHull == true) {
          drawHull();
        }
        
        //draw knot if doKnot boolean == true
        if (doKnot == true) {
          //drawKnot();
          strokeWeight(1);
          fill(200);
          beginShape(TRIANGLES);

          for (int i = 0; i < kVectors.length; i+=3) {

            //scale(.05);
            //knotMesh.addFace(kVectors[i], kVectors[i+1], kVectors[i+2]);

            vertex(kVectors[i]);
            vertex(kVectors[i+1]);
            vertex(kVectors[i+2]);
          }
          endShape();
        }
        
        //if we're in edit mode, enable rollover detection for vertices
        if (readSerial == false) {
          hitDetection();
        }
      }
    }
  }
  
  popMatrix();  
  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);

  //if in edit mode, show pop-up
  if (readSerial == false) {
    //myPort.stop();
    textSize(14);
    text("Edit Mode On", 100, 375, 0);
  }
  //do text cues after popMatrix so it doesn't rotate
  doMouseOvers(); //text cues on button rollover

  //ask for another reading
  myPort.write("A");
}

