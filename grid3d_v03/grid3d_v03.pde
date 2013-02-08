/* grid 3D mapper
 * v.03 - multiple switch inputs, and cleaner code
 * by Ben Leduc-Mills
*/

import processing.serial.*;

Serial myPort; // the serial port
float buttonId; // the button id we get from arduino if a button is switched

int gridSize = 10; //size of grid
int spacing = 10; //distance between pixels

void setup() {
 
 size(400, 300, P3D);
 //size(400, 300);
 
 println(Serial.list()); // list available serial ports
 
 myPort = new Serial(this, Serial.list()[0], 9600);
 
 myPort.bufferUntil('\n');

 background(255);  //set initial background color
  
}

void draw() {
  
  translate(width/2, height/2, -100);
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
  
  int coord[] = int(split(inString[], ',')); 
  
  //if (coord[0] != 0) {
  
  //convert to int so we can use it as a number
  //buttonId = float(inString);

  //draw grid
   for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        for( int k = 0; k < gridSize; k++) {
          if (coord[0] != 0) { //if a button is pressed, take the coordinate and make it more visable
            if (coord[0] == xpos && coord[1] == ypos && coord[2] == zpos) {
               strokeWeight(3);
               point(coord[0], coord[1], coord[2]);
               //point(xpos, ypos, zpos); 
               xpos += spacing;
            }
            else {
              strokeWeight(1);  
              point(xpos, ypos, zpos);
              xpos += spacing;
            }
          }
          else {
            strokeWeight(1);  
            point(xpos, ypos, zpos);
            xpos += spacing;
          }
        }
        xpos = 0;
        ypos += spacing;   
      }
      xpos = 0;
      ypos = 0;
      zpos += spacing; 
    }
  } 

 }

//}
