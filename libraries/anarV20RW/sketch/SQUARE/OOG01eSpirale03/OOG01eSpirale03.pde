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

  int numOfSides = 25;
  int numOfLoops = 5;
  float theta = 2*PI/(numOfSides*2);


  // starting point
  Pt a = Anar.Pt(50,0);
  Pt b = Anar.Pt(45,0);

  // rotation
  RotateZ rot = new RotateZ(theta);
  b.apply(rot);

  Translate t = new Translate(0,0,1);
  Scale s     = new Scale(.99f,.99f,.99f);


  //Create a new Line
  Pts myLine = new Pts();


  for (int i=0; i<numOfSides*numOfLoops; i++) {
    a = Anar.Pt(a);
    b = Anar.Pt(b);

    a.apply(rot);
    a.apply(rot);
    a.apply(t);
    a.apply(s);

    b.apply(rot);
    b.apply(rot);
    b.apply(t);
    b.apply(s);


    myLine.add(a);
    myLine.add(b);
  }


  //Store myLine in our object
  myObj.add(myLine);

  //Create a second line
  Pts myLine2 = new Line(myLine);
  myLine2.translate(0,0,10);
  
  myLine2.render = new RenderPtsLine(new AColor(255,0,0));

  //Store myLine2 in our object
  myObj.add(myLine2);
  
  
  println(a);
  //println(myObj.line(0).pt(1));
  

  //Create Sliders based on an object
  Anar.sliders(myObj); 
}



public void draw() {
  background(153);
  myObj.draw();
}
