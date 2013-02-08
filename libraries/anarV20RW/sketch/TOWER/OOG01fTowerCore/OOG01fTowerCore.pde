import anar.*;
import processing.opengl.*;

Anar     Anar;
Obj     towerCore         = new Obj();

Sliders mySlides;

public void setup(){
  size(800,400,OPENGL);
  Anar.init(this);

  // Setup DEFAULT rendering of our scene
  Anar.drawAxis(true);

  initForm();
}

void initForm(){
  // Here, we create an arbitrary shape
  Face myShape = new Star(100,50,5);

  // The initial shape is duplicated Applying always the same predefined
  // Transformation

  Param numOfSubDivisionsOnEachSides = new Param(6);

  Transform combo = new Transform();
  combo.translate(0,0,5);
  combo.scale(0.92f,0.945f,1.04f);
  combo.rotateZ(.06f);
  //combo.rotateX(.06f);

  for (int i = 0; i<24; i++){
    Face floorShape = new Face(myShape,combo);
    towerCore.add(floorShape);
    myShape = floorShape;
  }

  //Global scene setups
  Anar.camTarget(towerCore);
  //Anar.sliders(towerCore);
  mySlides = new Sliders(towerCore);
}

public void draw(){
  background(200);
  towerCore.draw();
  mySlides.draw();
}

