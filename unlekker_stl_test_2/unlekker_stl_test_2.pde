import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;

STL stl;

void setup() {
  size(400,400, P3D);

  
  
}

void draw() {
 background(255); 
 translate(width/2, height/2);
 rotateY(radians(frameCount));
 rotateX(radians(frameCount*0.25f));
 //fill(0);
 
 //box(20,20,20);
beginShape();

 vertex(0,0,0);
 vertex(0,0,50);
 vertex(0,50,0);
 vertex(0,50,50);
 vertex(50,0,0);
 vertex(50,0,50);
 vertex(50,50,0);
 vertex(50,50,50);

 endShape(CLOSE);
  
}

void keyPressed() {
 
  outputSTL();
  
}

public void outputSTL() {
  
  stl=(STL)beginRaw("unlekker.data.STL","Boxes.stl");
  
  //box(20,20,20);
beginShape(QUAD_STRIP);

 vertex(0,0,0);
 vertex(0,0,50);
 vertex(50,0,0);
 vertex(50,0,50);
 vertex(0,50,0);
 vertex(0,50,50);
 vertex(50,50,0);
 vertex(50,50,50);

 endShape(CLOSE);
  
  endRaw();
}
