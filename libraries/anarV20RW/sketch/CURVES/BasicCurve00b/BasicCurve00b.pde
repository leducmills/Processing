import processing.opengl.*;
import anar.*;


Obj myObj = new Obj();

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();
  initForm();
}

void initForm(){

  //First construction: a basic line
  Pts ctrlPts = new Pts();

  ctrlPts.add(0,0,0);
  ctrlPts.add(30,20,0);
  ctrlPts.add(60,-20,0);
  ctrlPts.add(90,0,0);
  ctrlPts.add(120,0,40);
  ctrlPts.add(150,0,0);
  ctrlPts.add(180,0,0);
  ctrlPts.stroke(155,0,0);   

  ctrlPts.translate(0,30,0);

  //To track the position of the point on the curve
  Param t = new Param(0.1f,0,1);

  //Add this first module
  Obj moduleA = createModule(ctrlPts,t);
  myObj.add(moduleA);

  //Create new controlPoints one from a symmetry
  Pts ctrlPtsSym = new Pts(ctrlPts, new MirrorY());

  //Create a new curve based on the new controlPoints
  Obj moduleB = createModule(ctrlPtsSym,t);
  myObj.add(moduleB);

  //Link the two moving points together
  Pts betweenCurves = new Pts();
  betweenCurves.add(moduleA.pt(0));
  betweenCurves.add(moduleB.pt(0));
  myObj.add(betweenCurves);

  Anar.sliders(moduleA);
  Anar.camTarget(ctrlPts);
}

Obj createModule(Pts construction, Param t){
  //Initialize a local object
  Obj module = new Obj();

  //From this first set of points, create a curve of degree 4
  CSpline curve = new CSpline(construction,4);
  curve.stroke(255,155,155);

  //Constrain a point on this curve for t=0.1
  Pt c = new PtCurve(curve,t);
  //Track parameters of point C
  Sliders cOnCurve = new Sliders(c);    
  //Anar.sliders(cOnCurve.get(cOnCurve.size()-1));        

  //Add Everything to our local object
  module.add(construction);
  module.add(curve);
  module.add(c);

  Anar.camTarget(construction);

  return module;
}

void draw(){
  background(155);
  myObj.draw();
}



