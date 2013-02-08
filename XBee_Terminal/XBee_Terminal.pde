/* 
 XBee Terminal
 */

import processing.serial.*;

Serial myPort;
String portnum;
String outString = "";
String inString = "";
int receivedLines = 0;
int bufferedLines = 10;

void setup() {

  size(400,300);

  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);

  println(Serial.list());

  portnum = Serial.list()[0];
  myPort = new Serial(this, portnum, 19200);
}

void draw() {

  background(0);
  text("Serial Port: " + portnum, 10, 20);

  text("typed: " + outString, 10, 40);
  text("received:\n" + inString, 10, 80);
}

void keyPressed() {


  switch(key) {

  case '\n':
    myPort.write(outString + "\r");
    outString = "";
    break;
  case 8:
    outString = outString.substring(0, outString.length() -1);
    break;
  case'+':
    myPort.write(key);
    outString += key;
    break;
  case 65535:
    break;
  default:
    outString += key;
    break;
  }
}


void serialEvent(Serial myPort) {

  int inByte = myPort.read();

  inString += char(inByte);

  if(inByte == '\r') {

    inString += '\n';
    receivedLines++;
    if (receivedLines > bufferedLines) {
      deleteFirstLine();
    }
  }
}


void deleteFirstLine() {
 
 int firstChar = inString.indexOf('\n');
 inString = inString.substring(firstChar+1);
  
}
