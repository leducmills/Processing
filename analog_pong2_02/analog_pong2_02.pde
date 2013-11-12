/* Analog Pong
 Reads in 1 sensor values from Arduino for the paddle controls
 Code by Ben Leduc-Mills, edited by Linz Craig
 */

import processing.serial.*; //import serial library

Serial myPort;
PFont myFont; //init font for text
int lf = 10; //linefeed in ASCII
Paddle leftPaddle, rightPaddle; //paddle objects
Ball pong; //ball object
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

PImage pStart; //PImage object for Start Screen
PImage pEnd; //PImage object for End Screen

//boolean started = 0; //Boolean variable to control Start Screen

void setup() {
  pStart = loadImage ("Pong_Start.png"); //Assigning the data or file to Start Screen object
  //pEnd = loadImage (“Pong_End.png”);     //Assigning the data or file to End Screen object

  size(1000, 600); //Size of Game Window
  rectMode(CENTER);
  ellipseMode(CENTER);
  myFont = createFont("FFScala", 16);
  textFont(myFont);
  println(Serial.list()); //list serial ports
  myPort = new Serial(this, Serial.list()[0], 9600); //init serial object (picks 1st port available)
  myPort.bufferUntil('\n');
  leftPaddle = new Paddle(padWidth, padHeight, distWall, leftPaddlePos); //init right paddle (width, height, x, y)
  rightPaddle = new Paddle(padWidth, padHeight, width - distWall, rightPaddlePos); //init left paddle
  //add new instance of Ball object called pong here
  pong = new Ball(15, width/2, height/2, 8, 2, 1, 1);
  
//  while (started == 0) {
//    image (pStart, 0, 0, width, height);//start game screen
//  }
}

void draw() {
  background(50);
  showGUI(); //shows scores, etc. (see GUI tab)
  pong.display(); 
  pong.update();
}

void serialEvent(Serial myPort) {

  String myString = myPort.readStringUntil('\n');

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

      //add parsing sensor into array code here

        // print out the values you got:
      //      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      //        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      //      }

      if (sensors.length > 1) {

        leftPaddlePos = sensors[0];
        
        //assign second sensor array value to rightPaddlePos here

        lpp = (float)leftPaddlePos;
        //reassign rightPaddlePos to the variable rpp of type float
        //println(rpp);

        //adjust these mapping functions to fit the sensors values you're receiving 
        lpp = map(lpp, 0, 255, 1, height);
        //rpp = map(rpp, 500, 900, 1, height);  //photocell
        rpp = map(rpp, 200, 1024, 1, height); //soft pot
        //rpp =  map(rpp, 150, 275, 1, height); //flex sensor

        //if(rpp != 0 || lpp != 0) {

        leftPaddle.display(lpp);
        rightPaddle.display(rpp);
        // }
      }
      // when you've parsed the data you have, ask for more:
      myPort.write("A");
    }
  }
}

void keyPressed() {
//  if (started == 0) {//so any key press starts the game
//    started = 1;
//  }
//  if (started == 1) {
//    pong.keyPressed();
//  }
}

