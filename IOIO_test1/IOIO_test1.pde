import apwidgets.*;

import ioio.lib.util.*;
import ioio.lib.impl.*;
import ioio.lib.api.*;
import ioio.lib.api.exception.*;


APWidgetContainer widgetContainer; 
APButton button1;
APButton button2;
int rectSize = 100;
boolean lightOn = false;


//MainActivity myActivity = new MainActivity();
//MainActivity.IOIOThread myIOIOThread = myActivity.new IOIOThread();
IOIOThread myActivity = new IOIOThread();

void setup() {

  thread("createIOIOThread");

  size(480, 800);
  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point

  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  button1 = new APButton(10, 10, "Toggle LED"); //create new button from x- and y-pos. and label. size determined by text content
  //button2 = new APButton(10, 60, 100, 50, "Bigger"); //create new button from x- and y-pos., width, height and label
  widgetContainer.addWidget(button1); //place button in container
  //widgetContainer.addWidget(button2); //place button in container
}

void draw() {
  //background(#FF9900);
  //rect(width/2, height/2, 150, 150);
  background(0);
  rect(width/2, height/2, rectSize, rectSize);
}

//onClickWidget is called when a widget is clicked/touched
void onClickWidget(APWidget widget) {

  if (widget == button1) { //if it was button1 that was clicked
    //rectSize = 100; //set the smaller size

    if (lightOn == true) {
      lightOn = false;
      rectSize = 50;
    }
    else if (lightOn == false) {
      lightOn = true; 
      rectSize = 100;
    }
  }
}


void createIOIOThread() {
  myActivity.createIOIOThread();


  try { 
    myIOIOThread.setup();
  } 
  catch (ConnectionLostException e) {
  }


  try { 
    myIOIOThread.loop();
  } 
  catch (ConnectionLostException e) {
  }
}




//

