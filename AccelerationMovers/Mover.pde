class Mover {

  PVector location, velocity, acceleration;
  float topSpeed;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    topSpeed = 5;
  }

  void update() {

    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location); //static usage b/c not changing either original vector

    dir.normalize();

    dir.mult(0.5);

    acceleration = dir;

    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
  }

  void display() {

    stroke(0);
    fill(200);
    ellipse(location.x, location.y, 25, 25);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } 
    else if (location.y < 0) {
      location.y = height;
    }
  }
}

