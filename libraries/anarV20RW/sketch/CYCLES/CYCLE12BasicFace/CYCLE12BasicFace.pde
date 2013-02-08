import processing.opengl.*;
import anar.*;



  Face myFace = new Face();

void setup(){
  size(300,150,OPENGL);
  Anar.init(this);

  myFace.add(Anar.Pt(0,0,0));
  myFace.add(Anar.Pt(0,100,0));
  myFace.add(Anar.Pt(100,100,0));
  myFace.add(Anar.Pt(100,0,0));
}

void draw(){
  background(255);
  
  myFace.draw();
}
