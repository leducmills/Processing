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

  //Create two transformations
  Translate t1 = new TranslateX(120);
  Translate t2 = new TranslateY(120);

  //Create point b from point a with the translation t1
  Pt b = a.copy().apply(t1);
  
  //Create a first line  
  Pts myLine1 = new Pts(a,b);
  
  //Copy and move the first line
  Pts myLine2 = myLine1.copy().apply(t2);

  //Create a new Face
  mySquare = new Face();

  //Store the points inside our Face
  myLine2.reverse();  //We want to pair points
  mySquare.add(myLine1);
  mySquare.add(myLine2);

  //Create Sliders based on an object
  Anar.sliders(b);  
}

void draw() {
  background(150);
  mySquare.draw();
}
