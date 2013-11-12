/* SerialBasic w/ handshake - 
 * Prints out a set of sensor readings from Arduino using the Serial Library
 */

import processing.serial.*; //import the Serial library

Serial myPort;  //the Serial port object
String val;

// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;  


void setup() {

  size(200, 200); //make our canvas 200 x 200 pixels big
  //  initialize your serial port and set the baud rate to 9600
  myPort = new Serial(this, Serial.list()[4], 115200);
  myPort.bufferUntil('\n');
}

void draw() {
  //we can leave the draw method empty, 
  //because all our programming happens in the SerialEvent (see below)
}

//the serialEvent method is called every time we get new stuff in on the serial port
//in this case we're constantly getting info, so it acts as our draw loop
void serialEvent( Serial myPort) {

  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');

  //make sure our data isn't empty before continuing
  if (val != null) {

    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);
    //println(val);

    //look for our 'A' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) {
      if (val.equals("hello")) {
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    }
    else { //if we've already established contact, keep getting and parsing data
      println(val);
      
      if (mousePressed == true) 
      {                           //if we clicked in the window
        myPort.write('1');         //send a 1
        println("1");
      }
      
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

