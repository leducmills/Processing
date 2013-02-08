
Mover[] movers = new Mover[20];
//Attractor a;

void setup() {
  size(1400, 800);
  //m = new Mover();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.2, 2), random(width), random(height));
  }

  //a = new Attractor();
  background(255);
}


void draw() {
  //background(255);

  //PVector force = a.attract(m);
  //m.applyForce(force);


  //a.display();

  for (int i = 0; i < movers.length; i++) {

    for (int j = 0; j < movers.length; j++) {

      if ( i != j) { //don't attract yourself

        PVector force = movers[j].attract(movers[i]); //for every mover, check every mover and attract it

        movers[i].applyForce(force);
      }
    }
    movers[i].update();
    //movers[i].checkEdges();
    movers[i].display();
  }


  //m.update();
  //a.display();
  //m.display();
}

