/* UCube v.04
 * 3d modeling input device and stl export
 * Manual rotation, shape mode toggle, and export button
 * by Ben Leduc-Mills
*/
import controlP5.*;
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;
import processing.serial.*;

Serial myPort; // the serial port
ControlP5 controlP5;
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
// String[] fontList = PFont.list();
// println(fontList);
 controlP5 = new ControlP5(this);
 controlP5.addButton("Export",0,100,100,150,30);
 controlP5.addButton("Mode", 0,100,131,150,30);

 myFont = createFont("FFScala", 32);
 textFont(myFont);
 
 
 println(Serial.list()); // list available serial ports
 myPort = new Serial(this, Serial.list()[0], 9600);
 myPort.bufferUntil('\n');
 //background(255);  //set initial background color (just looks nicer on startup)
  
}

void draw() {
 // controlP5.draw();
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
 controlP5.draw();
} //end draw

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.controller().name());
}

void mouseDragged() {
  float x1 = mouseX-pmouseX;
  float y1 = mouseY-pmouseY;
  rotX = (mouseY * -0.01);
  rotY = (mouseX * 0.01);
  
}

void translations() {  
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
}

void drawGrid() {
   
 //draw rest of grid 
 int xpos = 0;
 int ypos = 0;
 int zpos = 0;
  
  for (int i = 0; i < gridSize; i++) {
     for (int j = 0; j < gridSize; j++) {
       for( int k = 0; k < gridSize; k++) {
             stroke(100);
             strokeWeight(2);  
             point(xpos, ypos, zpos);
             xpos += spacing;
           }
       xpos = 0;
       ypos += spacing;   
         }
     xpos = 0;
     ypos = 0;
     zpos += spacing; 
     }  
}

void drawAxes() {
  
  stroke(255,0,255);
  line(0,0,0, 100,0,0);
  fill(255,0,255);
  text("X", 200, 0);
  stroke(0,255,0);
  line(0,0,0, 0,-100,0);
  fill(0,255,0);
  text("Y", 0, -200);
  stroke(0,0,255);
  line(0,0,0, 0,0,100);
  fill(0,0, 255);
  text("Z", 0, 0, 200);
  fill(0,0,0);
  //text("0,0,0", 0,0,0);
}

public void Export(int theValue) {
  outputSTL(); 
}

//function to output STL file
void outputSTL() {
  
  //make sure we have at least 4 points
  //(can't have a 3d shape with less)
  if (points.length > 3) {
    
    //compute the convex hull
    hull.build(points);

    //get an array of the vertices so we can get the faces  
    Point3d[] vertices = hull.getVertices();
  
    //start writing the stl file - file should appear in your sketch folder
    stl=(STL)beginRaw("unlekker.data.STL","convexhull.stl");  
  
    //different beginShape() modes may affect the shape produced 
    beginShape(QUADS);  
    //println ("Faces:");
    int[][] faceIndices = hull.getFaces();
    for (int i = 0; i < faceIndices.length; i++) {  
      for (int k = 0; k < faceIndices[i].length; k++) {
        
        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
      }
    }
    
    endShape(CLOSE);
    endRaw();
  }
}

public void Mode(int theValue) { 
  counter++;
  println(counter);
  showShape(); 
}

void showShape() {
 
 if (points.length > 3) {
     
    //compute the convex hull
    hull.build(points);

    //get an array of the vertices so we can get the faces  
    Point3d[] vertices = hull.getVertices();  
  
    //different beginShape() modes may affect the shape produced 
    beginShape();
    strokeWeight(1);
    //fill(100);  
    //println ("Faces:");
    int[][] faceIndices = hull.getFaces();
    for (int i = 0; i < faceIndices.length; i++) {  
      for (int k = 0; k < faceIndices[i].length; k++) {
        
        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
      }
    }
    
    endShape(CLOSE);
  }
  
}
