import anar.*;
import processing.opengl.*;



Obj myObj;


void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);

  initForm();
}


void initForm() {
  //Create a new Object to store our shape
  myObj = new Obj();

  //Create few points with absolute coordinates
  Pt a = Anar.Pt(-60, -60);
  Pt b = Anar.Pt(60, -60);
  Pt c = Anar.Pt(60, 60);
  Pt d = Anar.Pt(-60, 60);

  //Create a new Face
  Face mySquare = new Face();
  
  //Store the points inside our Face
  mySquare.add(a);
  mySquare.add(b);
  mySquare.add(c);	
  mySquare.add(d);
  
  //Store mySquare in our object
  myObj.add(mySquare);

  //Create Sliders based on an object
  Anar.sliders(myObj);	
}


void draw() {
  background(150);
  myObj.draw();
}

void keyPressed(){
  //SketchUpRuby.export(myObj, "output");
  Autolisp.export(myObj, "output2");
}
