import anar.*;
import processing.opengl.*;

Face myStar;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);
  initForm();
}

void initForm() {
  int numOfSides = 5;
  float theta = 2*PI/(numOfSides*2);

  Param p = new Param(100,0,100,3);

  // starting point
  Pt a = Anar.Pt(100,0);
  Pt b = Anar.Pt(50,0);

  // rotation
  RotateZ rot = new RotateZ(theta);
  b.apply(rot);

  //Create a new Face
  myStar = new Face();

  //Store the points inside our Face
  for (int i=0; i<numOfSides; i++) {
    a = Anar.Pt(a);
    b = Anar.Pt(b);

    a.apply(rot);
    a.apply(rot);

    b.apply(rot);
    b.apply(rot);

    myStar.add(a,b);
  }

  //Create Sliders based on an object
  Anar.sliders(myStar); 
}

public void draw() {
  background(153);
  myStar.draw();
}

