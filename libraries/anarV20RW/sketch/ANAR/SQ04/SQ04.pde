import anar.*;
import processing.opengl.*;



Obj myObj;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);

  initForm();
}

void initForm() {
  //Create a new Object to store our shape
  myObj = new Obj();  

  int numOfSides = 5;
  float theta = 2*PI/(numOfSides*2);

  Param p = new Param(100);


  // starting point
  Pt a = Anar.Pt(100,0);
  a.x(p);
  
  Pt b = Anar.Pt(50,0);

  // rotation
  RotateZ rot = new RotateZ(theta);
  b.apply(rot);


  //Create a new Face
  Face myStar = new Face();

  //Store the points inside our Face
  for (int i=0; i<numOfSides; i++) {
    a = Anar.Pt(a);
    b = Anar.Pt(b);

    a.apply(rot);
    a.apply(rot);

    b.apply(rot);
    b.apply(rot);

    myStar.add(a);
    myStar.add(b);
  }

  //Store myStar in our object
  myObj.add(myStar);

  //Create Sliders based on an object
  Anar.sliders(myObj); 
}


public void draw() {
  background(153);
  myObj.draw();
}
