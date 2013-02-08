
Mover[] movers = new Mover[50];

Liquid liquid;

void setup() {

  size(640, 480);
  background(255);

  for (int i = 0; i < movers.length; i++) {

    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
}

void draw() {
 
 background(255);
 
 liquid.display();
 
 
 //making up forces
 PVector wind = new PVector(0.01, 0);
 //PVector gravity = new PVector(0, 0.1);
 
 for(int i = 0; i < movers.length; i++) {
  
   if(movers[i].isInside(liquid)) {
    
    movers[i].drag(liquid);
     
   }
   
   
   float m = movers[i].mass;
   
   float c = 0.01; //coefficient of friction
   float normal = 1; //normal force perp to object
   float frictionMag = c * normal; //calc friction magnitude
   PVector friction = movers[i].velocity.get(); 
   friction.mult(-1); //friction goes the opposite way from velocity
   friction.normalize();
   friction.mult(frictionMag);
   

   
   
   PVector gravity = new PVector(0, 0.1*m);  //if want to reflect real-world gravity, need to scale by mass
   
  movers[i].applyForce(friction); 
  movers[i].applyForce(wind);
  movers[i].applyForce(gravity);
  
  movers[i].update();
  movers[i].checkEdges();
  movers[i].display();
   
 }
  
}
