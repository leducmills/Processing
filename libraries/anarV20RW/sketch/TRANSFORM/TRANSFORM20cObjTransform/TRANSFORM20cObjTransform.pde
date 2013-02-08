import anar.*;
import processing.opengl.*;


Obj myObj = new Obj();

public void setup(){
  size(800,400,OPENGL);
  frameRate(200);

  Anar.init(this);
  Anar.drawAxis(true);

  initForm();
}

void initForm(){

  //Create a new Face
  Face mySquare = new Star(1,2,5);

  //Create a new set of Transformations
  Transform myTransform = new Transform();
  myTransform.translate(2,0,0);
  myTransform.rotateZ(.5f);
  myTransform.scale(1,1.05f,1.015f);

  //Create a box from the previous square
  Obj box = new Extrude(mySquare,Anar.Pt(0,0,10));

  for(int i=0; i<200; i++)
  {
    Obj myCopy = new Obj(box);  //Create an obj from box
    myCopy.apply(myTransform);  //Apply the set of transformations to the copy
    if(random(2)>1)
      myObj.add(myCopy);        //Add myCopy obj to my main obj myObj
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
