float rotX, rotY;

void setup() {
  size(300,300, P3D);
}

void draw() {
background(255);
translations();
  
 beginShape();
vertex(30, 20, 50);
vertex(85, 20, 50);
vertex(85, 75, 50);
vertex(30, 75, 50);

vertex(30, 20, 0);
vertex(85, 20, 0);
vertex(85, 75, 0);
vertex(30, 75, 0);

vertex(30, 20, 0);
vertex(85, 20, 0);
vertex(85, 75, 50);
vertex(30, 75, 50);

vertex(85, 75, 0);
vertex(30, 75, 0);
vertex(30, 20, 50);
vertex(85, 20, 50);

vertex(85, 75, 50);
vertex(30, 75, 50);
vertex(30, 20, 0);
vertex(85, 20, 0);

vertex(30, 20, 50);
vertex(85, 20, 50);
vertex(85, 75, 0);
vertex(30, 75, 0);


 
 endShape();
  
}

void mouseDragged() {
  float x1 = mouseX-pmouseX;
  float y1 = mouseY-pmouseY;
  rotX = (mouseY * -0.01);
  rotY = (mouseX * 0.01);
  
}

void translations() {  
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
}
