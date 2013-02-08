int frameC;

void setup() {
  size(400,400, P3D);
  background(255);
  
}


void draw() {
  frameC = frameCount;
  rotateY(frameC * 0.01);
  line(100,100,300,300);
  
}

void keyPressed() {
  frameC = frameC * -1;
}
