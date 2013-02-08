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

  //Create a first point with absolute coordinates    
  Pt a = Anar.Pt(-60, -60);
  Pt b = Anar.Pt(60,-60);

  //Create a Translation
  Translate t1 = new Translate(0, 120, 0);

  //Create a first line
  Pts myLine1 = new Pts();

  //Create point b from point a with the translation t1
  Pt c = Anar.Pt(a,t1);   
  myLine1.add(a);
  myLine1.add(c);    

  //Create a second line
  Pts myLine2 = new Pts();

  //Create point b from point a with the translation t1
  Pt d = Anar.Pt(b,t1);   
  myLine2.add(b);
  myLine2.add(d);  

  //Create a new Face
  Face mySquare = new Face();

  //Store the points inside our Face
  mySquare.add(a);
  mySquare.add(b);
  mySquare.add(d);
  mySquare.add(c);


  //Store mySquare in our object
  myObj.add(mySquare);

  //Create Sliders based on an object
  Anar.sliders(myObj);  
}


void draw() {
  background(150);
  myObj.draw();
}
