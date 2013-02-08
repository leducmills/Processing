
Mover[] movers = new Mover[100];
Attractor a;

void setup() {
  size(800, 600);
  //m = new Mover();
  for(int i = 0; i < movers.length; i++) {
   movers[i] = new Mover(random(0.2,3), random(width), random(height)); 
  }
  
  a = new Attractor();
}


void draw() {
 background(255);

//PVector force = a.attract(m);
//m.applyForce(force);


a.display();

for(int i = 0; i < movers.length; i++) {
 
 PVector force = a.attract(movers[i]); 
  
 movers[i].applyForce(force);
 movers[i].update();
 movers[i].checkEdges();
 movers[i].display();
  
}


//m.update();
//a.display();
//m.display();

}
