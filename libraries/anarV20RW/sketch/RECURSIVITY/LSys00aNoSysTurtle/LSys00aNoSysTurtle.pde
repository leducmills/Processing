import processing.opengl.*;
import anar.*;



Pts pts = new Pts();

Pt turtle;
Transform[] T;

Sliders mySlide;

void setup() {
  size(1000, 500, OPENGL);
  Anar.init(this);

  Anar.drawAxis();
  initForm();
}


void initForm() { 

  T = new Transform[6];

  T[0] = new Translate(10,0,0);
  T[1] = new Translate(-10,0,0);
  T[2] = new Translate(0,10,0);
  T[3] = new Translate(0,-10,0);
  T[4] = new Translate(0,0,10);
  T[5] = new Translate(0,0,-10);

  turtle = Anar.Pt(0,0,0);

  pts = new Pts();
  pts.add(turtle);

  pts.stroke(255, 0, 0);

  for (int i=0; i<100; i++) step();	

  mySlide = new Sliders(pts);
}

void step() {
  // add new point from turtle using random translation
  Pt next = Anar.Pt(turtle, T[(int) random(6)]);

  pts.add(next);
  turtle = next;

  Anar.camTarget(pts);		
}

void draw() {
  background(153);
  pts.draw();
  mySlide.draw();
}


void keyPressed(){
  if(key==' ') {
    step();
  }
  if(key=='r') {
    initForm();
  }
}






