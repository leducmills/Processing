import anar.*;
import processing.opengl.*;

Obj myObj = new Obj();

void setup(){
  size(800,400,OPENGL);
  frameRate(200);
  Anar.init(this);
  Anar.drawAxis(true);
  initForm();
}

void initForm(){
  //Create a new Line
  Pts pts = new Pts();

  pts.add(Anar.Pt(10,0,0));
  pts.add(Anar.Pt(10,0,100));
  pts.add(Anar.Pt(20,0,110));
  pts.add(Anar.Pt(10,0,120));
  pts.add(Anar.Pt(10,0,200));

  //Create an object from a revolution around the Z axis
  //    30 is the number of elements per revolutions
  myObj = new Revolve(pts, Anar.Pt(0,0,20),30);

  //Change the color of the object
  myObj.fill(255,255,0);

  Anar.camTarget(myObj);
  Anar.sliders(myObj);
}

void draw(){
  background(155);

  myObj.draw();
  //myObj.fill(random(255),random(255),0);
}

void keyPressed(){
  Anar.slidersToggle();
}
