import processing.opengl.*;
import anar.*;



CSpline         cardinal;
Param pv;


void setup(){
  size(800,400,OPENGL);
  frameRate(200);

  Anar.init(this);
  Anar.drawAxis(true);
  initShape();

  Pts.globalRender = new RenderPtsAll();
  Pt.globalRender = new RenderPtEllipseOriented(new AColor(100),new AColor(255,0,0,150),2,Anar.scene);

  Anar.bsplineRes(20);
}


void initShape(){

  Pts baseLine = new Pts();
  baseLine.add(Anar.Pt(-50,0,0));
  baseLine.add(Anar.Pt(0,50,50));
  baseLine.add(Anar.Pt(50,0,0));
  //baseLine.add(Anar.Pt(-150,-60,40));

  for (int i = 0; i<1000; i++)
    baseLine.add(Anar.Pt(Anar.rnd(-50,50),Anar.rnd(-50,50),Anar.rnd(-50,50)));

  pv = new Param(1/.3f,0.01f,40);
  Anar.sliders(pv);

  cardinal = new CSpline(baseLine,pv);
  cardinal.closedMode = true;
  cardinal.mode = CSpline.NEXT;
  cardinal.stroke(225,215,205);

  Anar.camTarget(baseLine);
}


void draw(){
  background(190);
  cardinal.draw();
}
