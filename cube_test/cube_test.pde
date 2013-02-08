

void setup() {
 
 size(400, 300, P3D);
 stroke(0);
 noFill();
 
  
}

void draw() {
  
 background(255);
 
 //pushMatrix();
 translate(width/2, height/2);
 rotateX(frameCount * 0.01);
 rotateZ(frameCount * 0.01);
 box(50);
 //popMatrix();
  
}
