import processing.opengl.*;
import anar.*;


Obj myObj;

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  myObj = new Obj();
  Face pts = new Face();

  pts.add(Anar.Pt(0,0,0));
  pts.add(Anar.Pt(100,0,0));
  pts.add(Anar.Pt(100,0,100));
  pts.add(Anar.Pt(100,0,200));
  pts.add(Anar.Pt(0,0,200));

  println("AREA: "+pts.area());

  myObj.add(pts);

}

void draw(){
  background(155);
  myObj.draw();
}

void keyPressed(){
  if (key == ' ') initForm();
}

