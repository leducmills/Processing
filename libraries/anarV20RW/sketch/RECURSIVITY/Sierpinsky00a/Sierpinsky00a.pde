import processing.opengl.*;
import anar.*;

Anar       Anar;

Sliders   parameters;

Pt        a, b, c;
Pts       facePts;

Obj       obj;

Param mid;
Param     zero;

Sliders   mySlider;

int       nIteration = 0;

public void setup(){
  size(800,400,OPENGL);
  Anar.init(this);

  Scene.autoSeek = false;
  
  obj = new Obj();
  initForm();

  Pts.globalRender = new RenderPtsAll();
}


void reset(){
  obj.faces.clear();
  obj.pts.ptOrder.clear();

  facePts = new Pts();
  facePts.add(a);
  facePts.add(b);
  facePts.add(c);
  Face f = new Face(facePts);

  obj.add(f);

  nIteration = 0;

  addFourth = false;
  mySlider = new Sliders(obj);
}

void initForm(){

  mid = new Param(2,2,10);
  zero = new Param(0);

  a = Anar.Pt( -60, -30);
  b = Anar.Pt(60, -30);
  c = Anar.Pt(0,60);

  facePts = new Pts();
  facePts.add(a);
  facePts.add(b);
  facePts.add(c);
  Face f = new Face(facePts);
  
  obj.add(f);
  mySlider = new Sliders(obj);

}


void sierpinskyIteration(){

  nIteration++;
  println(nIteration);

  float z = 10.;

  float param;
  if(positive)
    param = z/ (nIteration*nIteration);
  else
    param = -z/ (nIteration*nIteration);
  Translate t = new Translate(Anar.Pt(zero,zero,new Param(param)));

  Obj newFaces = new Obj();

  for (int i = 0; i<obj.numOfFaces(); i++){


    Face f = obj.face(i);

    // use point of gravity of original point as anchor
    Pt pp = new PtBary(f);

    // get the vertices of the triangle
    Pt aa = f.pt(0);
    Pt bb = f.pt(1);
    Pt cc = f.pt(2);

    // get the middle points
    Pts AB = Forms.ptsMid(aa,bb,mid);
    Pts BC = Forms.ptsMid(bb,cc,mid);
    Pts AC = Forms.ptsMid(cc,aa,mid);

    Pt ab = Anar.Pt(AB.pt(1),t);
    Pt bc = Anar.Pt(BC.pt(1),t);
    Pt ac = Anar.Pt(AC.pt(1),t);

    // add first subdivision
    Pts fPts = new Pts();
    fPts.add(aa);
    fPts.add(ab);
    fPts.add(ac);
    Face f1 = new Face(fPts);

    // add second subdivision
    fPts = new Pts();
    fPts.add(ab);
    fPts.add(bb);
    fPts.add(bc);
    Face f2 = new Face(fPts);

    // add third subdivision
    fPts = new Pts();
    fPts.add(ac);
    fPts.add(bc);
    fPts.add(cc);
    Face f3 = new Face(fPts);

    newFaces.add(f1);
    newFaces.add(f2);
    newFaces.add(f3);

    if(addFourth){
      // add middle subdivisions

      fPts = new Pts();
      fPts.add(ab);
      fPts.add(bc);
      fPts.add(pp);
      Face f4 = new Face(fPts);
      newFaces.add(f4);

      fPts = new Pts();
      fPts.add(pp);
      fPts.add(bc);
      fPts.add(ac);
      Face f5 = new Face(fPts);
      newFaces.add(f5);

      fPts = new Pts();
      fPts.add(ab);
      fPts.add(pp);
      fPts.add(ac);
      Face f6 = new Face(fPts);
      newFaces.add(f6);

    }


  }

  // (gll) Here, if you have a look at Obj class you see that add(Face f) will
  // track parent stuff.
  // Then, when you say clear for faces arrayList, everything stay in parent
  // arrayList
  // In fact faces should be private (and might be private soon)
  // I still need access to faces arraylist for debug (or to construct my
  // classes)
  // but you should use something like set() and get()
  obj.faces.clear(); // Doesn't affect anything (might be better for the
  // collector (I dont know?)


  // Here is the proposal:
  // Create a brand new object (old obj go in the garbage collector, with
  // parents in)
  obj = new Obj();

  // Theres no obj(ArrayList<Face> f) yet, you need to copy them manually.
  for (int i = 0; i<newFaces.numOfFaces(); i++)
    obj.add(newFaces.face(i));

  // obj.faces = newFaces;
  Anar.camTarget(obj);
  mySlider = new Sliders(obj);
}


public void draw(){
  background(153);
  
  obj.draw();
  mySlider.draw();
}



boolean addFourth = false;
boolean positive  = false;

public void keyPressed(){

  switch(key){
  case 'q':
    sierpinskyIteration();
    break;
  case 'w':
    addFourth = !addFourth;
    break;
  case 'e':
    reset();
    break;
  case 'r':
    positive = !positive;
    ;
    break;

    // (gll) edited implemented (should be oneDay inside Ogg main class
  case 'a':
    // String buffer;
    String cmdName = ((Object)this).getClass().getName();

    Autolisp cad = new Autolisp();
    cad.CADWriteHeader(cmdName+".lsp",cmdName);
    cad.fW(obj.toAutocad());
    cad.fWln("\n\n\n\n\n");
    cad.CADWriteFooter(cmdName);

    // TextIO.writeTextFile(
    // ((Object)this).getClass().getName()+"A.lsp",myObj.toAutocad());

    break;



  }


}

