import anar.*;
import processing.opengl.*;

Sliders mySliders;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);
  
  //Create some parametric values
  Param a = new Param(50);
  Param b = new Param(50);
  
  //Param --> Value, Minimum, Maximum
  Param c = new Param(255,0,255);
  
  //Create a new Sliders List
  mySliders = new Sliders();
  mySliders.add(a);
  mySliders.add(b);
  mySliders.add(c);
}

void draw() {
  //Use the value to change the background color
  background(mySliders.get(0).toFloat(),mySliders.get(1).toFloat(),mySliders.get(2).toFloat());
  mySliders.draw();
}
