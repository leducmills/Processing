/*
 * Danger Shield VJDJ 
 * Using the Danger Shield from SparkFun to do live Video and Audio manipulation
 * by Ben Leduc-Mills - http://benatwork.cc
 * video code based off code by Dan Shiffman - http://shiffman.net
 * This code is public domain but you buy me a beer if you use this and we meet someday (Beerware license)
 */


//import processing.core.PApplet;
import processing.serial.Serial;
import processing.video.*;
import ddf.minim.*;

Capture myCamera;
MovieMaker mm;

Minim minim;
AudioSample kick;
AudioSample snare;

Serial usbPort;
// Size of each cell in the grid
int cellSize = 20;
// Number of columns and rows in our system
int cols, rows;
//int[] sensors;
String[] sensors;
boolean firstContact = false;

int slider1, slider2, slider3;
int button1, button2, button3;
int photoCell;

public void setup() {
  size(800, 600);

  minim = new Minim(this);
  kick = minim.loadSample("myrecording.wav", 2048);
  //snare = minim.loadSample("snare.wav", 2048);

  myCamera = new Capture(this, width, height, 30);
  mm = new MovieMaker(this, width, height, "drawing.mov");
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);

  usbPort = new Serial (this, Serial.list( )[0], 9600);
  usbPort.bufferUntil ('\n');

  background(0);
}

public void draw() {

  doSounds();

  if (myCamera.available()) {
    myCamera.read();
    myCamera.loadPixels();

    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {

        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (myCamera.width - x - 1) + y*myCamera.width; // Reversing x to mirror the image

        float r = red(myCamera.pixels[loc]);
        float g = green(myCamera.pixels[loc]);
        float b = blue(myCamera.pixels[loc]);
        // Make a new color with an alpha component
        int c = color(r, g, b, 55);

        // Code for drawing a single rect
        // Using translate in order for rotation to work properly
        pushMatrix();
        translate(x+cellSize/2, y+cellSize/2);

        // Rotation formula based on slider1 value
        rotate((float) (2 * PI * brightness(c) / slider1));
        rectMode(CENTER);

        fill(c);
        noStroke();
        // Width and height of rects are based on slider2 and slider3 values
        rect(0, 0, slider2/4, slider3/4);
        popMatrix();
      }
    }
  }

  mm.addFrame();
}

public void doSounds() {

  //if button1 is pressed, play kick sound
  if (button1 == 0) {

    //kick.trigger();
    kick.trigger();
  }

  //if button2 is pressed, play snare sound
  if (button2 == 0) {

    //snare.trigger();
  }
}


public void keyPressed() {
  if (key == ' ') {
    // Finish the movie if space bar is pressed
    mm.finish();
    // Quit running the sketch once the file is written
    exit();
  }
}

public void stop()
{
  // always close Minim audio classes when you are done with them
  kick.close();
  snare.close();
  minim.stop();

  super.stop();
}


public void serialEvent ( Serial usbPort ) {
  String usbString = usbPort.readStringUntil ('\n');
  if (usbString != null) {
    usbString = trim(usbString);

    //serial handshake
    if (firstContact == false) {
      if (usbString.equals("Hello")) {
        usbPort.clear();
        firstContact = true;
        usbPort.write('A');
        println("contact");
      }
    }
    else {

      //we got something, put the sensor values in their own variables
      sensors = split(usbString, ',');
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      }

      slider1 = Integer.parseInt(sensors[0]);
      button1 = Integer.parseInt(sensors[1]);
      slider2 = Integer.parseInt(sensors[2]);
      button2 = Integer.parseInt(sensors[3]);
      slider3 = Integer.parseInt(sensors[4]);
      button3 = Integer.parseInt(sensors[5]);
      photoCell = Integer.parseInt(sensors[7]);

      //request more data!
      usbPort.write("A");
    }
  }
}



