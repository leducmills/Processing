/* SerialBasic w/ handshake - 
 * Prints out a set of sensor readings from Arduino using the Serial Library
 */

import processing.serial.*; //import the Serial library

Serial myPort;  //the Serial port object 

// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;  


void setup() {

  //  initialize your serial port: 
  //  this code picks the first port in the array of available ports,
  //   and sets the baud rate to 9600
  myPort = new Serial(this, Serial.list()[0], 9600);
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
  String myString = myPort.readStringUntil('\n');

  //make sure our data isn't empty before continuing
  if (myString != null) {

    //trim whitespace and formatting characters (like carriage return)
    myString = trim(myString);
    //println(myString);

    //look for our 'hello' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) {
      if (myString.equals("Hello")) {
        myPort.clear();
        firstContact = true;
        myPort.write('A');
        println("contact");
      }
    }
    else { //if we've already established contact, keep getting and parsing data
      
      //split the string of data back into separate values, using the semicolon we printed in Arduino
      int sensors[] = int(split(myString, ','));
      //run through the sensor values and print them out
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
        //println(sensorNum);
      }
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

