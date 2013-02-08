import processing.opengl.*;
import anar.*;

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.debugTimeIn();
  initForm();
  Anar.debugTimeOut();
  Anar.drawAxis(true);

  Scene.gradientBackground = true;
  Scene.bloomInit(20);
}


void initForm(){

  Face star = new Face();
  int numberOfSides = 5;

  Param w1 = new Param(50,0,100).addToSlidersMain();
  Param w2 = new Param(50,0,100).addToSlidersMain();
  Transform rz = new RotateZ(PI/numberOfSides);

  Pt a = Pt.create(0,0,0).translateX(w1);
  Pt b = a.copy().translateX(w2).apply(rz);    

  for(int i=0; i<5; i++)
  {
    a = a.copy().apply(rz).apply(rz);
    b = b.copy().apply(rz).apply(rz);
    star.add(a,b);
  }

  Param height = new Param(5,0,30);

  Param d = new Param(100,80,110).tag("%").addToSlidersMain();
  Param sx = new Param(95,90,110).addToSlidersMain().div(d);
  Param sy = new Param(94,90,110).addToSlidersMain().div(d);
  Param sz = new Param(104,90,110).addToSlidersMain().div(d);
  Param r2 = new Param(6,-20,20).addToSlidersMain().div(d);

  Transform complex = new Transform();
  complex.translateZ(height);
  complex.scale(sx,sy,sz);
  complex.rotateZ(r2);

  for(int i=0; i<24; i++){
    Face floor = star.copy().apply(complex);
    Anar.add(floor);
    star = floor;
  }

}

void draw(){
  background(150);
  Anar.camTarget(Anar.main);
  Scene.bloom(Anar.main);
  Anar.draw();
}



