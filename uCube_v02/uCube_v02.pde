/* UCube v.02
 * 3d modeling input device and stl export
 * Adding rotation control, turning shape modeling on and off
 * by Ben Leduc-Mills
*/

import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;
import processing.serial.*;

Serial myPort; // the serial port
float buttonId; // the button id we get from arduino if a button is switched
STL stl; //init STL object
QuickHull3D hull = new QuickHull3D(); //init quickhull
Point3d[] points; //init Point3d array

int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 40; //distance between points 

void setup() {
 
 size(1000, 750, P3D);
 println(Serial.list()); // list available serial ports
 myPort = new Serial(this, Serial.list()[0], 9600);
 myPort.bufferUntil('\n');
 background(255);  //set initial background color (just looks nicer on startup)
  
}

void draw() {
  
  translate(width/2, height/2 -35, 300);
  //rotateY(frameCount * 0.002);
  //rotateY(mouseX * 0.01);
  //rotateX(mouseY * 0.01); 
  
}

void serialEvent (Serial myPort) {
 
 background(255);  
 int xpos = 0;
 int ypos = 0;
 int zpos = 0;
   
 //get the button ID
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
//    print(subCoord[0]);
//    print(subCoord[1]);
//    println(subCoord[2]);
      
  }
    
  //draw rest of grid
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
 
 } //end if inString!=null 
  
} //end SerialEvent


//if any key is pressed, output the STL file
void keyPressed() {
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
