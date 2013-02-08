import processing.opengl.*;
import anar.*;



Obj myObject;

Grammar grammar;

Obj box;

Transform T;
Translate initT;

Translate t;
RotateZ r;
Scale s;


void setup() {
  size(1000, 500, OPENGL);
  Anar.init(this);

  Anar.drawAxis();
  initGrammar();
  interpretInit();
}

void initGrammar() {
  grammar = new Grammar("bt");
  // here define the rules
  // * means any kind of symbol
  // the example rules below are therefore non contextual
  grammar.addRule("*b*", "brb");
  grammar.addRule("*t*", "rssb");
  grammar.addRule("*r*", "rs");
  grammar.addRule("*s*", "s");
  // this one makes it context dependant
  //		    grammar.addRule("sss", "ss");

  println(grammar);
}


void interpretInit() {
  // base element
  box = new Box(10,10,50);

  // initial position
  initT = new Translate(0,50,0);

  // base transformations
  t = new Translate(Anar.Pt(0,10,-.001f));
  r = new RotateZ(.5f);
  s = new Scale(Anar.Pt(.99f,.99f,.99f));

  interpretGrammar();		
}

void interpretGrammar() {
  myObject = new Obj();
  T = new Transform(initT);

  for (int i=0; i<grammar.numOfSymbols(); i++) {

    switch (grammar.symbol(i).charAt(0)) {	
    case 'b':
      Obj myCopy = new Obj(box, T);
      myObject.add(myCopy);
      T = new Transform(T);
      break;
    case 't':
      T.apply(t);
      break;
    case 'r':
      T.apply(r);
      break;					
    case 's':
      T.apply(s);
      break;					
    default:
      break;

    }
  }
  Anar.camTarget(myObject);
}

void draw() {
  background(153);
  myObject.draw();
}


void keyPressed(){
  if(key==' ') {
    grammar.step();
    interpretGrammar();
    println(grammar);
  }
  if(key=='r') {
    grammar.reset();
    interpretInit();
    interpretGrammar();
    println(grammar);

  }
}






