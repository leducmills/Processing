import anar.*;
import processing.opengl.*;

Obj myObj = new Obj();

public void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis(true);
  initForm();
}

void initForm(){

  //Definition of shape parameters	
  int numOfSides = 4;	
  float theta = 2*PI/numOfSides;

  //Create a first point with absolute coordinates    
  Pt a = Anar.Pt(-10, -10);

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

  //Create a new set of Transformations
  Transform myTransform = new Transform();
  myTransform.translate(20,0,0);
  myTransform.rotateZ(.5f);
  myTransform.scale(1,1.09f,1.05f);

  //Create a box from the previous square
  Obj box = new Extrude(mySquare,Anar.Pt(0,0,10));

  for(int i=0; i<30; i++)
  {
    Obj myCopy = new Obj(box);  //Create an obj from box
    myCopy.apply(myTransform);  //Apply the set of transformations to the copy
    myObj.add(myCopy);          //Add myCopy obj to my main obj myObj
    box = myCopy;               //Swap box <--> myCopy
                                //    myCopy is now the base for the next loop
  }

  Anar.camTarget(myObj);
  
  //Get the sliders from the set of transform
  //    Note: here, we don't use an obj to create the sliders.
  Anar.sliders(myTransform);
}

public void draw(){
  background(155);
  myObj.draw();
}
