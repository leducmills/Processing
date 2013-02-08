/* Toxiclibs stl test
 * by Ben Leduc-Mills
 * 2.02.11
 */
import processing.opengl.*;
import newhull.*;
//import java.awt.event.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import controlP5.*;

ControlP5 controlP5;
//Nav3D nav; // camera controller

QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array
Point3d[] savedPoints;

//ToxiclibsSupport gfx;
Mesh3D mesh = new TriangleMesh();
Vec3D[] vectors;

float rotX, rotY; //for manual roatation
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 50; //distance between points
int counter = 0; //wireframe toggle
String inString; //string of coordinates from arduino
String oldString;
boolean reDraw = true;
PFont myFont; //init font for text

void setup() {

  size(1000,750,OPENGL);
  //gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport
  background(255); 

  controlP5 = new ControlP5(this);
  controlP5.addButton("Refresh",0,100,100,80,19);
  controlP5.addButton("Mode", 0,100,120,80,19);
  controlP5.addButton("Export", 0,100,140,80,19);

  myFont = createFont("FFScala", 32);
  textFont(myFont);
  genPoints(); //generate random set of points
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
  //nav.transform(); // do transformations using Nav3D controller
  translations();
  drawGrid();
  drawAxes();

  //inString = "0,0,0;2,0,0;0,2,0;2,2,0;2,1,1;0,1,1;"; //tetrahedron (kinda)

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
      drawHull();
    }
  }//end if inString!=null
  
  popMatrix();
  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);
  
}







