import ioio.lib.spi.*;
import ioio.lib.api.*;
import ioio.lib.util.*;
import ioio.lib.util.android.*;
import ioio.lib.android.bluetooth.*;
import ioio.lib.impl.*;
import sikio.*;
import ioio.lib.android.accessory.*;
import ioio.lib.api.exception.*;

// Import extra libraries for Android functions
import apwidgets.*;
import android.view.MotionEvent; 

// Make a widget container and 8 buttons. Each button will play a note.
//APWidgetContainer widgetContainer; 
//APButton c;
//APButton d;
//APButton e;
//APButton f;
//APButton g;
//APButton a;
//APButton b;
//APButton c2;

// Status variable to check if main ioio loop has started running
boolean ioio_good = false;

int freq = 523;
boolean playTone;

void setup() 
{
  size(displayWidth, displayHeight);
  new SikioManager(this).start();

  // Wait for IOIOLoop to start running  ??? need ???
  while (ioio_good == false) {
  }
}

void draw() {

  // Set background to black.
  background(0, 0, 0);

  // Draw the white keys.
  fill(255);
  stroke(155);
  rect(50, 10, 50, height); // c
  rect(100, 10, 50, height); // d
  rect(150, 10, 50, height); // e
  rect(200, 10, 50, height); // f
  rect(250, 10, 50, height); // g
  rect(300, 10, 50, height); // a
  rect(350, 10, 50, height); // b
  rect(400, 10, 50, height); // c

  //Draw the black keys.
  fill(0);
  rect(75, 10, 50, 300); // c#
  rect(125, 10, 50, 300); // d#
  rect(225, 10, 50, 300); // f#
  rect(275, 10, 50, 300); // g#
  rect(325, 10, 50, 300); // a#
}

// This is a function to open the piezo pin at the correct frequency and play a tone, 
// the length of which is determined by the value we pass to the sleep() function.
//void playTone(int freq) 
//{
//  try 
//  {
//    piezo = ioio.openPwmOutput(piezoPin, freq);
//    piezo.setDutyCycle(.5);
//  } 
//  catch (ConnectionLostException e) 
//  {
//  }
//
//  try 
//  {
//    Thread.sleep(100); //??? here or in ioioloop ???
//  } 
//  catch (InterruptedException e) 
//  {
//  }
//  piezo.close();
//}

// This is called when there is a touch event.
public boolean surfaceTouchEvent(MotionEvent event) {  

  // There was a touch event - what kind?
  int action = event.getAction();

  // Get the X position of where the touch was, so we know which note to play.
  int pos = (int)event.getX();

  // If the action was a touch on the screen, play a note based on the positon of the touch.
  if (action == MotionEvent.ACTION_DOWN) {

    if (pos < 100) {
      freq = 523;
      playTone = true; 
    }  

    if (pos >= 100 && pos < 150) {
      freq = 587;
      playTone = true; 
    }

    if (pos >= 150 && pos < 200) {
      freq = 659;
      playTone = true; 
    }

    if (pos >= 200 && pos < 250) {
      freq = 698;
      playTone = true; 
    }

    if (pos >= 250 && pos < 300) {
      freq = 784;
      playTone = true; 
    }

    if (pos >= 300 && pos < 350) {
      freq = 880;
      playTone = true; 
    }

    if (pos >= 350 && pos < 400) {
      freq = 988;
      playTone = true; 
    }
    if (pos > 400) {
      freq = 1047;
      playTone = true; 
    }
  }

  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  return super.surfaceTouchEvent(event);
}

