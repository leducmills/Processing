

import processing.serial.*; //import serial library
import controlP5.*;


float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;
//Ball[] balls = new Ball[0];

ControlP5 controlP5;
float r, g, b;

Serial myPort;
int lf = 10; //linefeed in ASCII
Ball[] balls = new Ball[0]; //array of ball objects
int ballID = 0;
int lightSensor;


boolean firstContact = false; // Whether we've heard from the microcontroller

void setup() {
  controlP5 = new ControlP5(this);
  size(1400, 800);
  ellipseMode(CENTER);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[8], 9600); //init serial object (picks 1st port available)
  myPort.bufferUntil('\n');
  smooth();

  controlP5.addSlider("redVal", 0, 255, 128, width - 150, 50, 10, 50);
  controlP5.addSlider("greenVal",0,255,128,width - 100,50,10,50);
  controlP5.addSlider("blueVal",0,255,128, width - 50,50,10,50);
}

void draw() {
  background(0);
  stroke(lightSensor);
  fill(r,g,b);
  rect(width-200, 50, 40, 40);
  for (int i = 0; i < balls.length; i++) {
    //balls[i].collide();
    balls[i].display(); 
    balls[i].update();
    balls[i].wobble();
  }
  
  
}

void serialEvent(Serial myPort) {

  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {

    myString = trim(myString);

    // if you haven't heard from the microncontroller yet, listen:
    if (firstContact == false) {
      if (myString.equals("hello")) { 
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
        println("contact");
      }
    } 
    // if you have heard from the microcontroller, proceed:
    else {
      // split the string at the commas
      // and convert the sections into integers:
      int sensors[] = int(split(myString, ','));

      //print out the values you got:
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      }

      if (sensors.length > 1) {

        lightSensor= sensors[1];
        println(lightSensor);

        //fill(random(255),random(255),random(255),lightSensor);

        if (sensors[0] == 0) {
          //init ball (size, x, y, x speed, yspeed, x direction, y direction, alpha)
          balls = (Ball[]) append(balls, new Ball(random(5, 100), random(10), random(10), random(-10, 10), random(-10, 10), 1, 1, r, g, b, balls, ballID, random(10)));
          ballID = ballID +1;
          println(ballID);
        }
      }

      //String output = Integer.toString((int)r);
      // when you've parsed the data you have, ask for more:
      String output = Integer.toString((int)r) + ',' + Integer.toString((int)g) + ',' + Integer.toString((int)b) + '\n';
      //myPort.write((int)r + ',' + (int)g + ',' + (int)b + '\n');
      myPort.write(output);
    }
  }
}

void keyPressed() {
  if ( key == 'r') {

    if (balls.length > 0) {

      balls = (Ball[]) shorten(balls);
    }
  }
}

void redVal(float theColor) {
  r = theColor;
  //println("a slider event. setting background to "+ r);
}

void greenVal(float theColor) {
  g = theColor;
  //println("a slider event. setting background to "+ r);
}

void blueVal(float theColor) {
  b = theColor;
  //println("a slider event. setting background to "+ r);
}

