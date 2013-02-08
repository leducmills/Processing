class Mover {

  PVector location;
  PVector acceleration;
  PVector velocity;

  float mass;

  Mover(float m, float x, float y) {

    mass = m;

    location = new PVector(30, 30);
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

    stroke(0);
    fill(200);

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
      velocity.y *= -1;
      location.y = height;
    }
  }

  boolean isInside(Liquid l) {

    if (location.x > l.x && location.x < l.x + l.w && location.y > l.y && location.y < l.y + l.h) {

      return true;
    } 
    else {

      return false;
    }
  }


  void drag(Liquid l) {

    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed; //force's magnitude

    PVector drag = velocity.get();

    drag.mult(-1); //drag is opposite to velocity
    drag.normalize();

    drag.mult(dragMagnitude);  //magnitude & direction

    applyForce(drag);
  }
}

