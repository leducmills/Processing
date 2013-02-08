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


IOIO ioio = IOIOFactory.create();
myIOIOThread thread1; 

void setup() {
  thread1 = new myIOIOThread("thread1", 100);
  thread1.start();

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
  background(#FF9900);
  
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

