import voronoi.*;

import processing.opengl.*;
import anar.*;




Obj myObj;

void setup(){
    size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  
  // RANDOMS POINTS
  Pts inPts = new Pts();
  for (int i = 0; i<200; i++)
    inPts.add(Pt.rnd(400,400));
  
  myObj = new Voronoi(inPts);
}

void draw(){
  background(255);
  myObj.draw();
}

void keyPressed(){
  if(key==' ')
    initForm();
}

