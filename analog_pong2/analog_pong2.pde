/* Analog Pong
 *  Reads in 2 sensor values connected to an Arduino for the paddle controls
 *  by Ben Leduc-Mills
 *  This code is public domain but you buy me a beer if you use this and we meet someday (Beerware license)
 */

import processing.serial.*; //import serial library

Serial myPort;
PFont myFont; //init font for text
Paddle leftPaddle, rightPaddle; //paddle objects
Ball ball; //ball object
int padWidth = 15;
int padHeight = 60;
int leftPaddlePos = 0;
int rightPaddlePos = 0;
int distWall = 15; //paddle distance from wall
float lpp; //scaled left paddle position
float rpp; //scaled right paddle position


int playerOne = 0; //player 1 score (left paddle)
int playerTwo = 0; //player 2 score (right paddle)
boolean oneWins = false;
boolean twoWins = false;

boolean firstContact = false; // Whether we've heard from the microcontroller

void setup() {
  size(1000,600);
  frameRate(20);
  smooth();
  rectMode(CENTER);
  ellipseMode(CENTER);
  myFont = createFont("FFScala", 16);
  textFont(myFont);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[0], 115200); //init serial object (picks 1st port available)
  myPort.bufferUntil('\n');
  leftPaddle = new Paddle(padWidth, padHeight, distWall, leftPaddlePos); //init right paddle (width, height, x, y)
  rightPaddle = new Paddle(padWidth, padHeight, width - distWall, rightPaddlePos); //init left paddle
  ball = new Ball(15, width/2, height/2, 8, 2, 1, 1); 
  //init ball (size, x, y, x speed, yspeed, x direction, y direction)
}

void draw() {
  background(0);
  showGUI(); //shows scores, etc. (see GUI tab)
  ball.display(); 
  ball.update();
  
  leftPaddle.display(lpp);
  rightPaddle.display(rpp);
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

      // print out the values you got:
      //      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      //        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      //      }

      if(sensors.length > 1) {

        leftPaddlePos = sensors[0];
        rightPaddlePos = sensors[1];

        lpp = (float)leftPaddlePos;
        rpp = (float)rightPaddlePos;
        //println("right: " + rpp + " " + "left: " + lpp);
        //println(lpp);
        
        //adjust these mapping functions to fit the sensors values you're receiving 
        lpp = map(lpp, 0, 1023, 1, height);
        rpp =  map(rpp, 0, 1023, 1, height); //flex sensor

          
       
      }
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

void keyPressed() {
  ball.keyPressed();
}

