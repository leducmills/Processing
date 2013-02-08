import processing.opengl.*;
import anar.*;



Pts baseLine1  = new Pts();
Pts baseLine2  = new Pts();

CSpline cardinal1;
CSpline cardinal2;

Param degree1;
Param degree2;


void setup() {
  size(800,400,OPENGL);

  Anar.init(this);
  frameRate(200);

  Anar.drawAxis(true);
  Pts.globalRender = new RenderPtsAll();
  Pt.globalRender = new RenderPtEllipseOriented(new AColor(100),new AColor(255,100,100,150),2,Anar.scene);
  CSpline.globalRender.splineRes.set(30);

  initCurve1();
  initCurve2();
}


void initCurve1(){
  baseLine1.add(Anar.Pt(-50,0,0));
  baseLine1.add(Anar.Pt(0,50,0));
  baseLine1.add(Anar.Pt(50,0,0));
  baseLine1.stroke(155,0,0);

  degree1 = new Param(3f,0.1f,40);

  cardinal1 = new CSpline(baseLine1,degree1);
  cardinal1.closedMode = true;
  cardinal1.mode = CSpline.NEXT;
  //cardinal1.mode = CSpline.HIMSELF;
  //cardinal1.mode = CSpline.PREVIOUS;

  Anar.sliders(degree1);
  Anar.camTarget(baseLine1);
}


void initCurve2(){
  baseLine2.add(Anar.Pt(90,0,0));
  baseLine2.add(Anar.Pt(100,50,20));
  baseLine2.add(Anar.Pt(150,0,-30));
  baseLine2.add(Anar.Pt(100,-50,50));
  baseLine2.add(Anar.Pt(130,-20,30));
  baseLine2.stroke(155,0,0);

  degree2 = new Param(3f,0.1f,40);

  cardinal2 = new CSpline(baseLine2,degree2);
  cardinal2.closedMode = true;
  cardinal2.mode = CSpline.NEXT;
  //cardinal2.mode = CSpline.HIMSELF;
  //cardinal2.mode = CSpline.PREVIOUS;

  Anar.sliders(degree2);
  Anar.sliders(baseLine2.pt(3));
  Anar.camTarget(baseLine2);
}


void draw() {
  background(190);

  baseLine1.draw();
  baseLine2.draw();

  stroke(80);
  if(drawConstruction)
  {
    cardinal1.draw();
    cardinal2.draw(); 
  }
  else
  {
    cardinal1.drawConstructionLines();
    cardinal2.drawConstructionLines();
  }
}


private boolean drawConstruction = true;
void keyPressed(){
  switch(key){
  case ' ':
    if(drawConstruction) 
      drawConstruction = false;
    else
      drawConstruction = true;
    break;
  }
}
