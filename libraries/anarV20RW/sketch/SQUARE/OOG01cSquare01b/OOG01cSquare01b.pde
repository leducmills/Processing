import anar.*;
import processing.opengl.*;

Face mySquare;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);
  initForm();
}

void initForm() {
  //Create a first point with absolute coordinates    
  Pt a = Anar.Pt(-60, -60);
  Pt b = Anar.Pt(60,-60);

  //Create a Translation
  Translate t1 = new TranslateY(120);

  //Create point b from point a with the translation t1
  Pt c = a.copy().apply(t1);   

  //Create a first line
  Pts myLine1 = new Pts(a,b); 

  //Create point b from point a with the translation t1
  Pt d = b.copy().apply(t1); 
  
  //Create a second line
  Pts myLine2 = new Pts(b,d);

  //Create a new Face
  mySquare = new Face(a,b,d,c);

  //Create Sliders based on an object
  Anar.sliders(mySquare);  
}

void draw() {
  background(150);
  mySquare.draw();
}
