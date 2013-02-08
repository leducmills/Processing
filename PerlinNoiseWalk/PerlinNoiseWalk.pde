

Walker w = new Walker();

void setup() {
  size(640, 480);
  background(255);
  
}


void draw() {
  
  stroke(0, 50);
  fill(200, 10);
  
  w.step();
  ellipse(w.x, w.y, 50, 50);
  
}
