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

  //Create parameter array to store individual rotations values
  Param[][] myArray = new Param[25][25];

  Obj module;

  for (int i=0; i<myArray.length; i++) {
    for (int j=0; j<myArray[i].length; j++) {
      myArray[i][j] = new Param(random(5*edge));
      Transform t = new Transform();
      t.translate(edge*i,0,0);
      t.translate(0,0,edge*j);

      module = createModule(myArray[i][j]);

      //Apply the transformation
      module.apply(t);

      //Add the copy to myObj
      myObj.add(module);
    }
  }
  //Create sliders for the parameter array
  Anar.camTarget(myObj);
}

int edge = 40;

Obj createModule(Param p) {
  //Create the base points (here a square)
  ref = new Pt[4];
  ref[0] = Anar.Pt(-edge/2, 0, -edge/2);
  ref[1] = Anar.Pt(edge/2, 0,-edge/2);
  ref[2] = Anar.Pt(edge/2, 0, edge/2);
  ref[3] = Anar.Pt(-edge/2, 0,edge/2);

  //Create a new Face
  Face mySquare = new Face();

  //Store the local points inside the new face 
  for (int i=0; i<ref.length; i++)
    mySquare.add(ref[i]);

  //Extrude mySquare according to parameter p
  Param zero = new Param(0);
  return new Extrude(mySquare, Anar.Pt( zero, p, zero));  
}  


void draw() {
  background(150);
  myObj.draw();
}
