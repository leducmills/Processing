import processing.opengl.*;
import anar.*;
import lsys.*;



Pts pts = new Pts();

Pt turtle;
Transform[] T;

Grammar grammar;

Sliders mySlide;

void setup() {
  size(1000, 500, OPENGL);
  Anar.init(this);

  Anar.drawAxis();
  initGrammar();
  interpretInit();
}

void initGrammar() {
  grammar = new Grammar("XYZyxz");
  // here define the rules
  // * means any kind of symbol
  grammar.addRule("*X*", "XyXYX");
  grammar.addRule("*Y*", "YxYXY");
  grammar.addRule("*Z*", "ZxZXZ");
  grammar.addRule("*x*", "xYxyx");
  grammar.addRule("*y*", "yzyZy");
  grammar.addRule("*z*", "zyzYz");

  println(grammar);
}


void interpretInit() { 

  T = new Transform[6];

  T[0] = new Translate(10,0,0);
  T[1] = new Translate(-10,0,0);
  T[2] = new Translate(0,10,0);
  T[3] = new Translate(0,-10,0);
  T[4] = new Translate(0,0,10);
  T[5] = new Translate(0,0,-10);

  interpretGrammar();
}

void interpretGrammar() {
  pts = new Pts();
  turtle = Anar.Pt(0,0,0);
  pts.add(turtle);

  pts.stroke(255,0,0);

  for (int i=0; i<grammar.numOfSymbols(); i++) {

    Pt next = Anar.Pt(0,0,0);

    switch (grammar.symbol(i).charAt(0)) {	
    case 'X':			         
      next = Anar.Pt(turtle, T[0]);
      break;
    case 'Y':
      next = Anar.Pt(turtle, T[2]);
      break;
    case 'Z':
      next = Anar.Pt(turtle, T[4]);
      break;					
    case 'x':			         
      next = Anar.Pt(turtle, T[1]);
      break;
    case 'y':
      next = Anar.Pt(turtle, T[3]);
      break;
    case 'z':
      next = Anar.Pt(turtle, T[5]);
      break;					
    default:
      break;

    }
    pts.add(next);
    turtle = next;
  }

  Anar.camTarget(pts);
  mySlide = new Sliders(pts);
}

void draw() {
  background(153);
  pts.draw();
  mySlide.draw();
}


void keyPressed(){
  if(key==' ') {
    grammar.step();
    interpretGrammar();
    println(grammar);
  }
  if(key=='r') {
    grammar.reset();
    interpretGrammar();
    println(grammar);

  }
}






