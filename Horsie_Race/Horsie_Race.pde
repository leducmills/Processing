/*
 *** Horsie Race
 * Interactive Wireless Horse Race Game
 * Rob Faludi http://faludi.com from original code by Liz Arum http://lizarum.com
 * Uses audio input parsed by Arduino to advance onscreen horses
 *  via an XBee radio wireless connection
 *
 */

String VERSION = "1.00b3";

int PORT_NUMBER = 0; // use the number shown in the console window on startup that shows your XBee serial adapter

import processing.serial.*; // use serial library
import ddf.minim.*; // use the included minim sound library

// initialize fonts
PFont font;

// initialize objects
FinishLine fl;
Game horseRace;

int num=0; // number of horsies detected
boolean gameOver=false; // monitors state of game
AudioPlayer player; // initialize players for streaming long files
AudioPlayer player2;
AudioSnippet snippet;
AudioMetaData meta;
Minim minim; // initializes audio object

String msg=""; // presents the instructions
String clip; // presents sounds

boolean startRace=false; // whether we are in ready to race state
boolean setUpR=false; // whether to set up a race
boolean flag=false; // whether horse winning has been handled yet

//serial stuff
int startByte;
int UID;
int step;
Serial myPort;

// horse array
ArrayList horsies;

PImage setupImg, readyImg;

void setup() {
  noStroke(); // don't draw outlines
  smooth(); // use antialiasing
  size(1024,768); // create race window
  background(255); // white background
  font = loadFont("ACaslonPro-Italic-72.vlw"); // prepare fonts for display
  textFont(font, 36); // pick an initial font

    //initialize race
  horseRace=new Game(0x236802,"call_to_post.wav","tada.wav", "horse_trot.wav"); //create a Game object
  //set up finish line
  fl=new FinishLine(width-width/10); // create a FinishLine object

  //initialize array of horses
  horsies=new ArrayList(); //this array will store horse objects

  setDefaults(); // prepare for a new game

  //serial stuff
  println(Serial.list()); // show what the serial ports are
  try {
    myPort = new Serial( this,  Serial.list()[PORT_NUMBER],  9600 ); // use usb serial, 9600 baud
  }
  catch (Exception e) { // if port can't be opened, show an error
    println("Serial Port Error!! Check port selection in code after \"myPort\"");
    exit();
  }
  myPort.clear();
    setupImg = loadImage("race_scene.jpg");
    readyImg = loadImage("julep.jpg");
  drawScene1(); // draw the setup screen
  // makeFakes(); // makes fake horses for testing, usually commented out
}



void draw() {

  if(setUpR) { // if it's time to set up a new race
    if(player.position()<player.length()) { // and the sound is not close to completed
      startRace=false; // then wait
    }
    else { // otherwise if the sound is nearly done
      minim.stop(); // stop playing the clip
      background(10,200,150); // set the background to grassy green
      startRace=true; // flag that it's time for racing
      gameOver=false; // flag that the race is in progress
        snippet = minim.loadSnippet(horseRace.trot);
    }
  }



  if(keyPressed) { // if a key on the keyboard is pressed
    if (key == 's' || key == 'S') { // and the key is a letter s
      setDefaults(); // set up the race start configurations
      gameOver=false; // flag that a race is in progress
      drawScene2(); // draw the Get Ready scene
      resetHorsies(); // put the horses at the starting line
      setUpRace(); //...and now play the call to the post
    }
  }

  if(startRace) { // if a race is underway
    drawScene3(); // draw the race in progress
  }
}



//////////////////////////

// puts all the horses at the starting line
void resetHorsies() {
  Horsie h;
  Collections.sort(horsies, new Comparator() {

    public int compare(Object o1, Object o2) {
      Horsie h1 = (Horsie) o1;
      Horsie h2 = (Horsie) o2;
      println("h1:" + h1.number + " h2:" + h2.number);
      return h1.number - h2.number;
    }
  }
  );

  for (int i=0; i<horsies.size(); i++) {
    Horsie m = (Horsie) horsies.get(i);
    m.position = i;
    horsies.set(i, m);
  }

  for(int i=0;i<horsies.size();i++) {
    h=(Horsie)horsies.get(i);
    h.xPos=h.w/2;
  }
}




// draws the setup screen
void drawScene1() {
  try {
  background(255);
  imageMode(CORNER);
  tint(255, 96); // reduce the alpha on the image
  image(setupImg, 0, 0, width, height);
  fill(0);
  textFont(font, 36);
  textAlign(CENTER);
  text("HORSIE RACE", width/2, height/2-height/8);
    text("Number of horses: " + horsies.size(),  width/2, height/2);
  text("Press \"S\" to start", width/2, height/2+height/8);
  }
  catch (Exception e) {
    print("Exception in drawScene1: " + e);
  }
    
}


// draw the get ready screen
void drawScene2() {
  background(255);
    imageMode(CORNER);
  tint(255, 96); // reduce the alpha on the image
  image(readyImg, 0, 0, width, height);
  fill(0);
    textAlign(CENTER);
  textFont(font,72);
  text("Get Ready!", width/2, height/2);
}



// draw the race screen
void drawScene3() {
  background(horseRace.bg);
  //display horses

  for (int i=0; i<horsies.size(); i++) {
    Horsie h=(Horsie) horsies.get(i); // get each horse from the array list
    h.display(); // show that horse
    strokeWeight(1);
    stroke(255,255,255,50);
    line(0,h.yPos+h.h/2,fl.xPos,h.yPos+h.h/2); // draw that horse's lane line
  }

  //display finish line
  fl.display();
  fill(255);
  textFont(font, 36);
  textAlign(CENTER);
  text(msg, width/2, height/2);
}


// runs any time there's at least one incoming byte in the serial buffer
void serialEvent( Serial myPort ) {

  if(myPort.available() >=3) { // if there's at least three bytes in the buffer
    int inByte = myPort.read(); // read a byte
    if (inByte==255) { // if it's the start byte
      UID= myPort.read(); // ...then the next byte is the Unique ID
      print("UID: " + UID);
      step=myPort.read(); // ...and the following byte is the step reading for how far the horse should move
      println(" step: " + step);

      // attempt to get a horse
      boolean horseFound = false;
      Horsie h = new Horsie(0,0,0,0);



      for (int i=0; i<horsies.size(); i++) {
        h=(Horsie) horsies.get(i);
        if (h.number == UID) {
          horseFound = true;
          break;
        }
      }
      if (horseFound==false && UID != 255) { // traps for bad packet sequence. checksum would improve this
        makeHorse(UID, horsies.size()); // make a horse
        h=(Horsie) horsies.get(horsies.size()-1);
        println("created horse #" + UID);
      }

      if(startRace) { // if the race is running
        if(h.xPos+h.w/2<fl.xPos-1) { // and the horse has not crossed the finish line
          h.move(step/2); // move the horse by the step value
          if (step > 50) snippet.play(); // if it's a significant step play a noise
          println("move " + h.number);
        }
        else { // if this horse has crossed the finish line
          gameOver=true; // end the race
          clip=horseRace.cheer; // get the cheer sound ready
          if(!flag) { // show which horse won
            horseWon(UID-1, clip,"Horse "+(UID)+ " Wins");
            flag=true;
          }
        }
      }
    }
  }
}

