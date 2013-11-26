/* 
 SparkFun SIKIO - Circuit 1
 Hardware Concept: Digital Out
 Android Concetp: Buttons
 CC BY-SA, http://creativecommons.org/licenses/by-sa/3.0/
 
 PURPOSE:
 This example shows how to control a tri-color LED with 3 buttons.  
 
 HARDWARE:
 -Tri-color LED
 -3 330Ohm resistors
 
 OPERATION:
 In this example, your app will have three buttons that control ON/OFF for each color 
 of the tri-color LED and the color of the background. Pin 3 on the IOIO is connected 
 to the red LED, Pin 2 is connected to green, and Pin 1 is connected to blue. These are
 defined in the IOIO_Thread_C1.
 */

//Import the IOIO libraries. If you want to interact with the IOIO board, you must 
//include all of these files. These come from the IOIO folder in your Processing ->
//libraries directory.
import ioio.lib.util.android.*;
import ioio.lib.spi.*;
import ioio.lib.util.*;
import ioio.lib.impl.*;
import ioio.lib.api.*;
import ioio.lib.api.exception.*;

//Create a IOIO instance. This is the entry point to the IOIO API. It creates the
//bootstrapping between a specific implementation of the IOIO interface and any
//dependencies it might have, such as the underlying connection logic.
IOIO ioio = IOIOFactory.create();

//Create an instance of our IOIOThread class. The thread code is found in IOIOThread.pde. The 
//thread runs independently of the main sketch below.
IOIOThread thread1; 

//Import apwidgets. This is responsible for easily creating buttons. Examples found here:
//  http://code.google.com/p/apwidgets/w/list
import apwidgets.*;

//Make a widget container and 3 buttons, one for each color.
APWidgetContainer widgetContainer; 
APButton redButton;
APButton greenButton;
APButton blueButton;

//This ia a boolean variable that reads if the LED is on or off. The variable can be
//used in this file or the IOIOThread.pde file. 
boolean lightOn = false;

//Create boolean variables that will be read by our thread when buttons are pressed.
boolean redOn, greenOn, blueOn = false;

//int redOn, greenOn, blueOn = -1;
int redVal, greenVal, blueVal = 0;

PFont font;

void setup() {

  //instantiate our thread, with a thread id of 'thread1' and a wait time of 100 milliseconds
  thread1 = new IOIOThread("thread1", 100);
  //start our thread
  thread1.start();

  font = createFont(PFont.list()[0], 32);
  textFont(font);

  //Drawing options.
  noStroke(); //disables the outline
  rectMode(CENTER); //place rectangles by their center coordinates

  background(0, 0, 0); //draw black background

  //Create a new container for widgets
  widgetContainer = new APWidgetContainer(this); 

  //Create a new button from x and y pos. and label. Size determined by text content.
  redButton = new APButton(10, 40, "Red"); 
  greenButton = new APButton(70, 40, "Green");
  blueButton = new APButton(150, 40, "Blue");

  //Place buttons in container
  widgetContainer.addWidget(redButton);
  widgetContainer.addWidget(greenButton);
  widgetContainer.addWidget(blueButton);
}

//Main draw loop is repeated 60 times a second. 
void draw() {

  //Nothing here now, you can add code in the draw loop. Remember, the buttons will be 
  //displayed on top of the background and will function out of the main draw loop.

  text(redVal, 10, 150);
  text(greenVal, 70, 150);
  text(blueVal, 150, 150);
}


//onClickWidget is called when a widget is clicked/touched.
void onClickWidget(APWidget widget) {

  ;
  //Each button toggles the boolean associated with that button's led color
  //In the ioio thread, we switch the LED on or off based on the status of that boolean.
  if (widget == redButton) { 
    redOn = !redOn;
      //background(255, 0, 0); //draw red background
    if (redOn == true) { 
      redVal = 255;
    };
    if (redOn == false) { 
      redVal = 0;
    };
  }

  if (widget == greenButton) {
    greenOn = !greenOn;
      //background(255, 0, 0); //draw red background
    if (greenOn == true) { 
      greenVal = 255;
    };
    if (greenOn == false) { 
      greenVal = 0;
    };
  }

  if (widget == blueButton) {
    blueOn = !blueOn;
      //background(255, 0, 0); //draw red background
    if (blueOn == true) { 
      blueVal = 255;
    };
    if (blueOn == false) { 
      blueVal = 0;
    };
  }

  background(redVal, greenVal, blueVal);
}

