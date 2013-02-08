import processing.opengl.*;
import anar.*;




Obj myObject;

Pt a,b,c;
Param div;

Grammar grammar;

Sliders mySlider;


void setup() {
  size(1000, 500, OPENGL);
  Anar.init(this);

  Anar.drawAxis();
  initForm();
}

void initGrammar() {
  grammar = new Grammar("s");
  // here define the rules
  // * means any kind of symbol
  // the example rules below are therefore non contextual
  grammar.addRule("*s*", "ksk");
  grammar.addRule("*ks", "s");
  grammar.addRule("sk*", "s");
  // this one makes it context dependant
  grammar.addRule("sks", "k");
  grammar.addRule("skk", "s");
  grammar.addRule("kks", "s");
  grammar.addRule("kkk", "k");		    
  println(grammar);
}


void initForm() {
  //definition of shape parameters
  div = new Param(2, 2, 10);

  a = Anar.Pt(-60, -30);
  b = Anar.Pt(60, -30);
  c = Anar.Pt(0, 60);

  reset();
}

void reset() {
  // construction of shape
  myObject = new Obj();

  // add base triangle
  Face f = new Face();
  f.add(a);
  f.add(b);
  f.add(c);	
  myObject.add(f);

  initGrammar();

  // define sliders for shape
  mySlider = new Sliders(myObject);
}

void recursivIteration() {


  // prepare new object to store new faces
  Obj newObj = new Obj();

  // go through each triangle and subdivide it
  for (int k = 0; k<myObject.numOfFaces(); k++){
    Face f = myObject.face(k);

    if (grammar.symbol(k).charAt(0)=='k') {
      // here rules are made to increase
      newObj.add(f);
      continue;
    }

    // get the vertices of the triangle
    Pt aa = f.pt(0);
    Pt bb = f.pt(1);
    Pt cc = f.pt(2);

    // get the middle points (by default div = 2)
    Pts AB = new PtsMid(aa, bb, div);
    Pts BC = new PtsMid(bb, cc, div);
    Pts AC = new PtsMid(cc, aa, div);

    // get the first in the sequence of middle points
    Pt ab = AB.pt(1);		
    Pt bc = BC.pt(1);		
    Pt ac = AC.pt(1);		

    // add first subdivision
    Face addFace = new Face();
    addFace.add(aa);
    addFace.add(ab);
    addFace.add(ac);
    newObj.add(addFace);

    // add second subdivision
    addFace = new Face();
    addFace.add(ab);
    addFace.add(bb);
    addFace.add(bc);
    newObj.add(addFace);

    // add third subdivision
    addFace = new Face();
    addFace.add(ac);
    addFace.add(bc);
    addFace.add(cc);
    newObj.add(addFace);

  }

  myObject = newObj;

  Anar.camTarget(myObject);
  mySlider = new Sliders(myObject);
}

void draw() {
  background(153);

  myObject.draw();
  mySlider.draw();
}


void keyPressed() {
  switch (key) {
  case ' ':
    recursivIteration();
    // apply grammar rules for next step
    grammar.step();
    println(grammar);
    break;
  case 'r':
    reset();
    break;
  }

}



