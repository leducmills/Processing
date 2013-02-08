/* Analog Pong
 Reads in 2 sensor values from Arduino for the paddle control
 
 */


import processing.serial.*;

Serial myPort;
int leftPaddle;
int rightPaddle;
int lf = 10; //linefeed in ASCII

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
  size(600,600);
}

void draw() {

  while (myPort.available() > 0) {

    byte[] inBuffer = new byte[7];
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
    
    leftPaddle = int(inBuffer[0]);
    rightPaddle = int(inBuffer[1]);
//    println(rightPaddle); 
//    background(rightPaddle); 
      
    }
  }
}

