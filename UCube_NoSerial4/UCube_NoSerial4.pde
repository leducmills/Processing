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
Nav3D nav; // camera controller

QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array
Point3d[] savedPoints;

//ToxiclibsSupport gfx;
Mesh3D mesh = new TriangleMesh();
Vec3D[] vectors;  //vec3D version of the point array
Vec3D[] sVectors; //spline vectors
Vec2D[] mouseOverVectors; //for keeping track of mouseover

float rotX, rotY; //for manual roatation
float x, y;
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 70; //distance between points
int counter = 0; //wireframe toggle
String inString; //string of coordinates from arduino
String oldString;
String message; // for UI hints
boolean reDraw = true;
boolean doFill = true;
boolean doGrid = true;
boolean doSpline = false;
boolean mouseOver = false;
boolean doHull = false;
int vertexMouseOver = -1;
PFont myFont; //init font for text
PrintWriter output; //for saving shape
BufferedReader reader; // for loading shapes

void setup() {

  size(1400,850,OPENGL);
  //gfx=new ToxiclibsSupport(this); // initialize ToxiclibsSupport
  background(255); 
  initControllers(); // initialize interface, see "GUI" tab
  myFont = createFont("FFScala", 32);
  textFont(myFont);
  mouseOverVectors = new Vec2D[0];
  //genPoints(); //generate random set of points
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

  if (doGrid == true) {
    drawGrid();
  }

  if (doSpline == true) {
    drawSpline();
  }

  drawAxes();

  //inString = "0,0,0;2,0,0;0,2,0;2,2,0;2,1,1;0,1,1;"; //tetrahedron (kinda)
  inString = "0,0,0;0,0,2;0,2,0;0,2,2;2,0,0;2,0,2;2,2,2;2,2,0;";
  //inString = "0,0,0;";

  if (inString != null) {

    //println(reDraw); 
    //make acive points more visible 
    strokeWeight(8);
    stroke(255, 0, 0); 

    if (inString.equals(oldString)) {
      //reDraw = false;
    }
   else { 
      oldString = inString;

      reDraw = true;
      inString = trim(inString);

      //split string of mutliple coordinates into coordinate-sized chuncks
      String coord[] = split(inString, ';');

      //init point3d and vectors arrays equal to number of activated points
      points = new Point3d[coord.length-1]; 
      vectors = new Vec3D[coord.length];

      //put the xyz coordinates into the point3d array and the vector3D and draw them
      for(int i = 0; i < coord.length-1; i++) {

        float subCoord[] = float(split(coord[i], ','));
        points[i] = new Point3d(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing);
        vectors[i] = new Vec3D(subCoord[0] * spacing, subCoord[1] * -spacing, subCoord[2] * spacing);
      }
    }

    if (vectors.length > 0) {

      for (int j = 0; j < vectors.length-1; j++) {
        //println(vectors[j]); 
        float x = vectors[j].x;
        float y = vectors[j].y;
        float z = vectors[j].z;
        point(x,y,z);
      }
    }
  

    //call drawHull function if Hull button is 
    if (doHull == true) {
      drawHull();
    }

    hitDetection();
  } //end if inString!=null

  popMatrix();

  // turn off depth test so the controlP5 GUI draws correctly
  hint(DISABLE_DEPTH_TEST);

  //do text cues after popMatrix so it doesn't rotate
  if (mouseOver == true) {
    textSize(14);
    text("Edit Mode On", 100, 375, 0);
  }
  
  
  doMouseOvers(); //text cues on button rollover
}

