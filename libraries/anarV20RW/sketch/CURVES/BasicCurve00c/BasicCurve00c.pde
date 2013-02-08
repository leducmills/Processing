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
  
  ctrlPts.translate(0,60,0);
  
  //Add this first module
  Pts moduleA = createModule(ctrlPts);
  myObj.add(moduleA);
  
  //Create new controlPoints one from a symmetry
  Pts ctrlPtsSym = new Pts(ctrlPts, new MirrorY());
  
  //Create a new curve based on the new controlPoints
  Pts moduleB = createModule(ctrlPtsSym);
  myObj.add(moduleB);
  
  //Create Faces
  for(int i=1; i<moduleA.numOfPts(); i++)
  {
    Face f = new Face();
    
    f.add(moduleA.pt(i-1));
    f.add(moduleB.pt(i-1));
    f.add(moduleB.pt(i));
    f.add(moduleA.pt(i));
    
    myObj.add(f);
  }

  Anar.sliders(ctrlPts);
  Anar.camTarget(myObj);
}

Pts createModule(Pts construction){

  //From this first set of points, create a curve of degree 4
  CSpline curve = new CSpline(construction,4);
  
  //Extract a serie of points from the curve
  Pts curveWithPointsUniform = curve.getPts(30);    
  
  return curveWithPointsUniform;
}

void draw(){
  background(155);
  myObj.draw();
}



