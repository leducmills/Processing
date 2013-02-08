import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;

// STLBoxes.pde - demonstrates how to use unlekkerLib to 
// import / export STL geometry data.
//
// Marius Watz - http://workshop.evolutionzone.com/
 
STL stl;

public void setup() {
  size(400,400, P3D);
  frameRate(25);
  sphereDetail(12);
}
 
public void draw() {
  translate(width/2,height/2);
 
  if(frameCount==10) outputSTL();
  //else if(frameCount==11) readSTL();
  if(frameCount< 12) return;
 
  background(0);
  noStroke();
  lights();
  rotateY(radians(frameCount));
  rotateX(radians(frameCount*0.25f));
  fill(0,200,255, 128);
  //stl.draw();

}
 
//public void readSTL() {
//  stl=new STL(this,"Boxes.stl");
//  stl.normalize(400); // scale object
//  stl.center(); // center it around world origin
//}
 
public void outputSTL() {
  float rad;

  stl=(STL)beginRaw("unlekker.data.STL","Boxes.stl");
  for(int i=0; i< 200; i++) {
    pushMatrix();
    translate(random(-200,200),0,-random(400));
    rotateX(((float)(int)random(6))*radians(30));
    rotateY(((float)(int)random(6))*radians(30));

    rad=random(5,25);
    if(random(100)>5) box(rad,random(50,200),rad);
    else sphere(rad);
    popMatrix();
  }
  endRaw();
}


