
/* SimonSketch - A Simon Tweak from Sparkfun
 * Use the buttons on your simon to pick colors, 
 * the trimpots to move your cursor
 * 2 = yellow
 * 6 = red
 * 9 = green
 * 12 = blue
 * incoming string = buttonPress;leftPot;rightPot 
 * if no button press, then just leftPot;rightPot
 */

import processing.serial.*;

Serial myPort;
SimonCursor myCursor;
int leftPot;
int rightPot;
float sizePot = 0;
int lightSensor = 0;

float x;
float y;
float siz;
float light;
// our high and low photocell values
//int high = 550;
//int low = 150;
int high = 1023;
int low = 0;

boolean firstContact = false; // Whether we've heard from the microcontroller



void setup() {

  size(1000, 750);
  background(255);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[0], 9600); //init serial object (picks 1st port available)
  myPort.clear();
  myPort.bufferUntil('\n');
  stroke(255);
  smooth();
}


void draw() {
}

void serialEvent(Serial myPort) {

  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {

    myString = trim(myString);
    //println(myString);

    if (firstContact == false) {
      if (myString.equals("hello")) {
        myPort.clear();
        firstContact = true;
        myPort.write('A');
        println("contact");
      }
    }
    else {
      int sensors[] = int(split(myString, ';'));
      // print out the values you got:
      //    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      //      println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      //      println(sensors.length);
      //    }

      leftPot = sensors[0];
      rightPot = sensors[1];
      sizePot = sensors[2];
      lightSensor = sensors[3];

      y = (float)leftPot;
      x = (float)rightPot;
      siz = (float)sizePot;
      light =(float)lightSensor;

      y = map(y, 0, 1023, 0, height);
      x = map(x, 0, 1023, 0, width);
      siz = map(siz, 0, 1023, 2, 50);
      light = map(light, low, high, 0, 255);

      myCursor = new SimonCursor(x,y,siz,light);
      
      println("X: " + x + " " + "Y: " + y + " " + "Size: " + siz + " " + "Light: " + light);

     // ellipse(x, y, siz, siz);
     myCursor.render();

      //if there's an extra value, a button has been pressed, so change the color
      if (sensors.length > 4) {

        int colorC = sensors[4];
        myCursor.changeColor(colorC);
      }

      if (sensors.length > 5) {  //if you press 2 buttons, set to erase mode
        fill(255);
        stroke(255);
      }
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

