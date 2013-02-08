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
  myObj = createModule();
}

Obj createModule(){
  //Initialize a local object
  Obj module = new Obj();
  
  //First construction: a basic line
  Pts construction = new Pts();
  
  construction.add(0,0,0);
  construction.add(30,20,0);
  construction.add(60,-20,0);
  construction.add(90,0,0);
  construction.add(120,0,40);
  construction.add(150,0,0);
  construction.add(180,0,0);
  construction.stroke(155,0,0);
  
  //From this first set of points, create a curve of degree 4
  CSpline curve = new CSpline(construction,4);
  curve.stroke(255,155,155);
  
  //Constrain a point on this curve for t=0.1
  Pt c = new PtCurve(curve,0.1f);
  //Track parameters of point C
  Sliders cOnCurve = new Sliders(c);    
  Anar.sliders(cOnCurve.get(cOnCurve.size()-1));    
  
  //Create a new line with non uniform distribution of points
  Pts curveWithPoints = new Pts();
  float i = 0;
  
  while(i<1)
  {
    curveWithPoints.add(new PtCurve(curve,i));
    i += random(0.1f);
  }
  
  curveWithPoints.translate(0,10,0);
  curveWithPoints.drawPoints();    

  //Create set of Points from an uniform distribution of points
  Pts curveWithPointsUniform = curve.getPts(30);
  curveWithPointsUniform.translate(0,30,0);
  curveWithPointsUniform.drawPoints();
  
  //Add Everything to our object
  module.add(curve);
  module.add(construction);
  module.add(curveWithPoints);
  module.add(curveWithPointsUniform);
  module.add(c);
  
  Anar.camTarget(construction);
  
  return module;
}

void draw(){
  background(155);
  myObj.draw();
}



