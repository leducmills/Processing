import anar.*;
import processing.opengl.*;

Obj myObj;
Sliders mySliders;

Pt[] ref;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);
  initForm();
}

void initForm() {
  //Create a new Object to store our shape
  myObj = new Obj();  

  //Create a vertical translation defining the height of tower floors
  Transform t = new Translate(0,0,10);

  //Create parameter array to store individual rotations values
  Param[] myArray = new Param[25];

  Obj module = createModule();

  for (int i=0; i<myArray.length; i++) {
    //Create individual rotations randomly
    myArray[i] = new Param(random(.4f), -3.14f, 3.14f);

    //Create transformation that include a translation 
    // and a new rotation on the axis Z created from p
    Transform tt = new Transform();
    tt.add(t);
    tt.rotateZ(myArray[i]);
    
    //Create a copy of module
    Obj myCopy = new Obj(module);

    //Apply the transformation
    myCopy.apply(tt);

    //Add the copy to myObj
    myObj.add(myCopy);

    //copy is now the base module
    module = myCopy;
  }

  //Create sliders for the parameter array
  mySliders = new Sliders(myArray); 
  
  //mySliders = new Sliders(myObj); 
  Anar.camTarget(myObj);
}

Obj createModule() {
  int edge = 40;
  int h = 9;

  //Create the base points (here a square)
  ref = new Pt[4];
  ref[0] = Anar.Pt(-edge/2, -edge/2);
  ref[1] = Anar.Pt(edge/2,-edge/2);
  ref[2] = Anar.Pt(edge/2, edge/2);
  ref[3] = Anar.Pt(-edge/2,edge/2);

  //Create a new Face
  Face mySquare = new Face();

  //Store the local points inside the new face 
  for (int i=0; i<ref.length; i++)
    mySquare.add(ref[i]);

  //Extrude mySquare along the translation t
  return new Extrude(mySquare, Anar.Pt(0,0,h));  
}  

void draw() {
  background(150);
  myObj.draw();
  mySliders.draw();
}
