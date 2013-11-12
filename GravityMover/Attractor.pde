class Attractor {
 
 float mass;
 PVector location;
 float G;
 
 Attractor() {
  
  location = new PVector(width/2, height/2);
  mass = 20;
  G = .9;
   
 }
 
 void display() {
  
  stroke(0);
  fill(175, 200);
  ellipse(location.x, location.y, mass*2, mass*2);
   
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
