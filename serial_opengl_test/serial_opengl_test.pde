import processing.opengl.*;
import processing.serial.*;


Serial myPort; // the serial port
int val;

void setup() {
  
  size(640,480,OPENGL);
  
  println(Serial.list()); 
  myPort = new Serial(this, Serial.list()[0], 9600);
  //myPort.bufferUntil('\n');
}


void draw() {
 
  if (myPort.available() > 0) {
    val = myPort.read();
    println("serial");
  }
  background(255);
  
}

