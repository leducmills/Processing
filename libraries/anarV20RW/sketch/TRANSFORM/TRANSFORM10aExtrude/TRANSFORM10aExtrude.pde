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

  pts.add(Anar.Pt(100,110,20));
  pts.add(Anar.Pt(110,100,40));
  pts.add(Anar.Pt(110,90,60));
  pts.add(Anar.Pt(90,90,90));

  //Create a Face
  Face f = new Star(50,100,5);

  //Extrude the face along the Line
  myObj = new Extrude(f,pts);


  Anar.camTarget(myObj);
  Anar.sliders(myObj);
}

void draw(){
  background(155);
  myObj.draw();
}

//Toggle the display of the sliders
void keyPressed(){
  Anar.slidersToggle();
}
