/* Analog Read from Arduino
   Change Background color based on analog sensor value
   This code is in the Public Domain
 */

import processing.serial.*;

Serial myPort;

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 9600);
  size(600,600);
}

void draw() {
}

void serialEvent(Serial myPort) {

  int in = myPort.read();
  //in = (byte)in;
  background(in);
  println(in);
}

