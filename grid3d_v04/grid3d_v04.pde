import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;

/* grid 3D mapper
 * v.04 - multiple switch inputs, and cleaner code
 * by Ben Leduc-Mills
*/

import processing.serial.*;

Serial myPort; // the serial port
float buttonId; // the button id we get from arduino if a button is switched
STL stl;
int gridSize = 4; //size of grid
int spacing = 15; //distance between pixels


void setup() {
 
 size(800, 600, P3D);
 //size(400, 300);
 
 println(Serial.list()); // list available serial ports
 
 myPort = new Serial(this, Serial.list()[0], 9600);
 
 myPort.bufferUntil('\n');

 background(255);  //set initial background color
  
}

void draw() {
  
  translate(width/2, height/2 -50, 200);
  rotateY(frameCount * 0.01);
  
  
}

void serialEvent (Serial myPort) {
 
 background(255); 
  
 int xpos = 0;
 int ypos = 0;
 int zpos = 0;
 
  
 //get the button ID
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
  
  //trim whitespace
  inString = trim(inString);
  
  String coord[] = split(inString, ';');
  
 pushMatrix(); 
  
 //draw active points on grid 
  
  for (int i = 0; i < coord.length -1; i++ ) {
  
    int subCoord[] = int(split(coord[i], ','));
    strokeWeight(3);
    point(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing );
  
  }
  
  //draw rest of grid
  
     for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
          for( int k = 0; k < gridSize; k++) {
                strokeWeight(1);  
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
     
  popMatrix();   
     
  } 
  
}

void keyPressed() {
  outputSTL();
}

void outputSTL() {
  
//  if (points.length > 3) {
//  
//  hull.build(points);  
//  Point3d[] vertices = hull.getVertices();
  
  stl=(STL)beginRaw("unlekker.data.STL","convexhull.stl");  

  for (int i = 0; i < coord.length -1; i++ ) {
  
    int subCoord[] = int(split(coord[i], ','));
    strokeWeight(3);
    point(subCoord[0] * spacing, subCoord[1] * spacing, subCoord[2] * spacing );
  
  }


  endRaw();
  }

