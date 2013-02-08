/* grid 3D mapper
 * v.01
 * by Ben Leduc-Mills
*/

import processing.serial.*;

Serial myPort; // the serial port
float buttonId; // the button id we get from arduino if a button is switched

void setup() {
 
 size(400, 300, P3D);
 //size(400, 300);
 
 println(Serial.list()); // list available serial ports
 
 myPort = new Serial(this, Serial.list()[0], 9600);
 
 myPort.bufferUntil('\n');
 
 background(255);  //set initial background color
  
}

void draw() {
 
  
}

void serialEvent (Serial myPort) {
 
  
 //get the button ID
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
  
  //trim whitespace
  inString = trim(inString);
 
  //convert to int so we can use it as a number
  buttonId = float(inString); 
  
  //draw the point
  if ( buttonId == 3 ) {
     stroke(0);
     point (30, 20, -50);
     //ellipse(20, 30, 20 ,20);
    }
    
  else if (buttonId == 0 ) {
    stroke(255);
    point (30, 20, -50);
    //ellipse(20, 30, 20, 20);
  }  
    
   
  }
  
 }
  

