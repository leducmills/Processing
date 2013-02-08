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
  
  //Definition of shape parameters	
  int numOfSides = 4;	
  float theta = 2*PI/numOfSides;

  //Create a first point with absolute coordinates    
  Pt a = Anar.Pt(-60, -60);
  
  // rotation
  RotateZ r = new RotateZ(theta);

  //Create a new Face
  Face mySquare = new Face();

  for (int i=0; i<numOfSides; i++) {
    //Create a point from a previous
    Pt newPt = Anar.Pt(a,r);
    mySquare.add(newPt);
    a = newPt;
  }

  //Store mySquare in our object
  myObj.add(mySquare);

  //Create Sliders based on an object
  Anar.sliders(myObj);  
}

void draw() {
  background(153);
  myObj.draw();
}
