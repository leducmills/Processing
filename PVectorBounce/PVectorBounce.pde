
PVector location, velocity;

void setup() {
  size(640, 360);
  location = new PVector(100, 100);
  velocity = new PVector(2.5, 2.5);
}

void draw() {

  background(255);

  location.add(velocity);

  if ((location.x > width) || (location.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  
  if ((location.y > height) || (location.y < 0)) {
   velocity.y = velocity.y * -1; 
  }
  
  
  stroke(0);
  fill(175);
  ellipse(location.x, location.y, 25, 25);
  
  
}

