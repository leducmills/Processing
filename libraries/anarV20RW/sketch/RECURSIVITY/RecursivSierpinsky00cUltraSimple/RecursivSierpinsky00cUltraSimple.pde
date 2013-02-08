import processing.opengl.*;
import anar.*;




Pt a,b,c;
Param div;
int nIteration = 0;

Obj obj;
Sliders mySlider;

void setup() {
  size(800, 400, OPENGL);
  Anar.init(this);
  Scene.autoSeek = false;

  initForm();
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
  obj = new Obj();

  // add base triangle
  Face f = new Face();
  f.add(a);
  f.add(b);
  f.add(c);	
  obj.add(f);

  // define sliders for shape
  mySlider = new Sliders(obj);

  nIteration = 0;		
}

void recursivIteration() {

  nIteration++;
  println(nIteration);

  // prepare new object to store new faces
  Obj newObj = new Obj();

  // go through each face and subdivide it
  for (int k = 0; k<obj.numOfFaces(); k++){
    Face f = obj.face(k);

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

  obj = newObj;

  Anar.camTarget(obj);
  mySlider = new Sliders(obj);
}


void draw() {
  background(153);

  obj.draw();
  mySlider.draw();
}


void keyPressed() {
  switch (key) {
  case ' ':
    recursivIteration();
    break;
  case 'r':
    reset();
    break;
  }

}





