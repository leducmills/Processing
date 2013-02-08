import processing.opengl.*;
import anar.*;



void setup(){
  size(600,300,OPENGL);
  Anar.init(this);

  Anar.drawAxis(true);
  
  createForm();
}

Obj form;

void createForm(){
  form = new Obj();
  Pt p = Anar.Pt(0,0,0);
  form.add(p);
}

void draw(){
  background(255);
  form.draw();
}


void keyPressed(){
  saveFrame("..//OUT//CYCLE05.jpg");
}
