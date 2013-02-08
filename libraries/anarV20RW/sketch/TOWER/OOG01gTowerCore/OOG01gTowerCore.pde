import anar.*;
import processing.opengl.*;

Anar     Anar;
Obj     towerCore         = new Obj();


public void setup(){
  size(800,400,OPENGL);
  //size(screen.width,screen.height,OPENGL);
  Anar.init(this);

  // Setup DEFAULT rendering of our scene
  Anar.drawAxis(true);

  initForm();
}


void initForm(){
  // Here, we create an arbitrary shape
  Pts myShape = new Star(100,50,5);

  // The initial shape is duplicated Applying always the same predefined
  // Transformation

  Param numOfSubDivisionsOnEachSides = new Param(6);

  Transform combo = new Transform();
  combo.translate(0,0,5);
  combo.scale(0.92f,0.945f,1.04f);
  combo.rotateZ(.06f);
  combo.rotateX(.06f);

  for (int i = 0; i<24; i++){
    Pts pTmp = new Pts(myShape,combo);
    CSpline floorShape = new CSpline(pTmp,10);
    floorShape.apply(combo);
    towerCore.add(floorShape);
    myShape = pTmp;
  }

  //Global scene setups
  Anar.camTarget(towerCore);
  Anar.sliders(towerCore);
}


public void draw(){
  background(200);
  towerCore.draw();
  
  println(frameCount);
  
  if(frameCount==100)
  {
    print("gotcha");
    saveFrame("myFrame###.jpg");
  }
}
