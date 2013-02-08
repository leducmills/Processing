class Mover {

  PVector location;
  PVector acceleration;
  PVector velocity;

  float mass;
  float G;

  Mover(float m, float x, float y) {
    //Mover() {

    mass = m;
    G = 0.5;

    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {

    PVector f = force.get(); //make a copy of force before using

    f.div(mass);

    acceleration.add(f);
  }

  void update() {

    velocity.add(acceleration); //motion 101
    location.add(velocity);

    acceleration.mult(0); //clear acceleration each time
  }

  void display() {

    stroke(0, 50);
    fill(200, 20);

    ellipse(location.x, location.y, mass*20, mass*20); //scale size according to mass
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } 
    else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    }

    else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }

  PVector attract(Mover m) {

    PVector force = PVector.sub(location, m.location); //direction of gravitational force
    float distance = force.mag();

    distance = constrain(distance, 3.0, 15.0); //constrain distance so things don't get out of hand

    force.normalize();
    float strength = (G * mass * mass) / (distance * distance);

    force.mult(strength);

    return force;
  }
}

