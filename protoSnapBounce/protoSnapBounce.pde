/* Analog Pong
 Reads in 2 sensor values from Arduino for the paddle controls
 
 */

import processing.serial.*; //import serial library

Serial myPort;
int lf = 10; //linefeed in ASCII
Ball[] balls = new Ball[0]; //array of ball objects
//int numBalls = 0;
int lightSensor;


boolean firstContact = false; // Whether we've heard from the microcontroller

void setup() {
  size(1400,800);
  ellipseMode(CENTER);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[0], 9600); //init serial object (picks 1st port available)
  myPort.bufferUntil('\n');
  smooth();
}

void draw() {
  background(0);
  stroke(lightSensor);
  for(int i = 0; i < balls.length; i++) {

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

      if(sensors.length > 1) {

        lightSensor= sensors[1];
        println(lightSensor);

        if(lightSensor < 20) {  //red
          fill(200, 0,0, lightSensor + 30);
        }
        if(lightSensor > 20 && lightSensor < 50) {  //green
          fill(0,200,0, lightSensor+ 20);
        }
        if(lightSensor > 50) { //blue
          fill(0,0,250,lightSensor+ 10);
        }

        if(sensors[0] == 0) {
          //init ball (size, x, y, x speed, yspeed, x direction, y direction)
          balls = (Ball[]) append(balls, new Ball(random(5,100), random(10), random(10), random(-10, 10), random(-10,10), 1, 1));
        }
      }

      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

void keyPressed() {
  if( key == 'r') {
     
     if(balls.length > 0) {
     
     balls = (Ball[]) shorten(balls);
     }
   }
}

