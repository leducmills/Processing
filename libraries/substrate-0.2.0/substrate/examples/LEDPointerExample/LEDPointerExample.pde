/**
  * (c)  oblong industries, inc.  2012
  * 
  * LED Pointer Example
  * 
  * This example shows how to use the
  * gspeaker library with the arduino library to control
  * real live LEDs with your iOS gspeak pointer app!
  * 
  * IMPORTANT NOTE: If you want to run this sketch WITH arduino,
  * search for arduino on this tab and in the digiLed class's draw method
  * and uncomment the lines that call arduino 
  *
  * Make sure you have installed the standard firmata sketch
  * on your arduino and that it is connected to your computer
  * 
  * **Places to get dependencies (as of 5/8/2012)**
  * you can get the arduino IDE from
  * http://www.arduino.cc/
  * you can get the Arduino library for Processing and
  * the Firmata library for Arduino from
  * http://www.arduino.cc/playground/Interfacing/Processing
  * 
  * 
  * **Hardware and circuitry**
  * Leds should be set up in a row, on sequential pins, starting on pin 2
  * for more information on wiring an array of LEDS, see
  * http://arduino.cc/en/Tutorial/Blink or
  * http://arduino.cc/en/Tutorial/ForLoop
  *
  **/

//import cc.arduino.*;    //for arduino, uncomment this
//Arduino arduino;        //for arduino, uncomment this

import processing.serial.*;
import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;

DigiLed[] digiLeds;
ArrayList<LedPointer> lPointers;

PFont theOnlyFont;

int lowestIndex;
//set this to the total number of leds you wired up
static int ledNum = 12;

void setup()
{
  //setup our arduino and gspeaker objects
//  arduino = new Arduino(this, Arduino.list()[0], 57600);  //for arduino, uncomment this
  substrate = new Substrate(this);

  size (700, 300);
  smooth ();
  theOnlyFont = createFont("Arial", 24);
  textAlign (CENTER);

  //create the digital LEDS
  digiLeds = new DigiLed[ledNum];
  createDigiLeds();

  lPointers = new ArrayList<LedPointer>();
}

void createDigiLeds()
{ 
  //sets up the position of the digiLeds onscreen
  float xin;
  float yin = height/2;
  for (int i = 0; i < digiLeds.length; i++)
  {
    xin = width/(digiLeds.length+1)*(i+1);
    digiLeds[i] = new DigiLed( xin, yin, 40, 2+i);
    digiLeds[i] . setOnOrOff(false);
  }
}

void draw()
{
  background(120);
  fill(255);
  stroke(0);

  //set all leds to off
  for ( DigiLed d : digiLeds )
  {
    d.setOnOrOff(false);
  }
  //see if anyone wants to have one on
  for ( LedPointer lp : lPointers )
  {
    lp.turnOnClosestLed (digiLeds);
  }
  
  //draw everything
  for ( int i = 0; i < digiLeds.length; i++ )
  {
    digiLeds[i].draw();
  }
  for ( LedPointer lp : lPointers )
  {
    lp.draw();
  }

  textFont (theOnlyFont);
  textSize (18);
  fill(255);
  text("Try pointing at the physical leds instead of looking at the screen",
        width*0.5, height*0.8);
}

void pointerAppeared(Pointer p)
{
  lPointers.add( new LedPointer(p) );
}
