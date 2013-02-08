/* UCube v.0x
 * 3d modeling input device and stl export
 * No Serial communication, ued for software feature building
 * by Ben Leduc-Mills
*/
import controlP5.*;
import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;
//import processing.serial.*;

//Serial myPort; // the serial port
ControlP5 controlP5;
PFont myFont; //init font for text
STL stl; //init STL object
QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array

float rotX, rotY;
int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 40; //distance between points 

void setup() {
myFont = createFont("FFScala", 32);
 textFont(myFont);

 size(1000, 750, P3D);
// println(Serial.list()); // list available serial ports
// myPort = new Serial(this, Serial.list()[0], 9600);
// myPort.bufferUntil('\n');
 background(255);  //set initial background color (just looks nicer on startup)
  
}

void draw() {
  
 //translate(width/2, height/2 -35, 300);
 //rotateY(frameCount * 0.002);
 
 background(255);

 pushMatrix();
 translations();
 drawGrid();
 //drawAxes();
 popMatrix();
 
}

void mouseDragged() {
  rotX = (mouseY * 0.01);
  rotY = (mouseX * 0.01);
  
}

void translations() {  
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
}
     //mouse rotate
     






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
