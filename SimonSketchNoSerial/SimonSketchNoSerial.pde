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
int lf = 10;
int leftPot;
int rightPot;

float x = width/2;
float y = height/2;

boolean firstContact = false; // Whether we've heard from the microcontroller



void setup() {

  size(1000, 750);
  background(255);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[0], 9600); //init serial object (picks 1st port available)
  myPort.clear();
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

      y = (float)leftPot;
      x = (float)rightPot;

      y = map(y, 0, 1023, 0, height);
      x = map(x, 0, 1023, 0, width);

      println("X: " + x + " " + "Y: " + y);

      ellipse(x, y, 5, 5);

      //if there's a third value, a button has been pressed, so change the color
      if (sensors.length > 2) {

        int colorC = sensors[2];
        changeColor(colorC);
      }

      if (sensors.length > 3) {  //if you press 2 buttons, set to erase mode
        fill(255);
        stroke(255);
      }
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

void changeColor(int colorC) {
  //match the color to the button press
  switch (colorC) {
  case 2: //yellow
    stroke(255, 255, 0);
    fill(255, 255, 0);
    break;
  case 6: //red
    stroke(255, 0, 0);
    fill(255, 0, 0);
    break;
  case 9: //green
    stroke(0, 255, 0);
    fill(0, 255, 0);
    break;
  case 12: //blue
    stroke(0, 0, 255);
    fill(0, 0, 255);
    break;
  default:
    stroke(0, 0, 255);
  }
}

