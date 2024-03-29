import processing.opengl.*;
import anar.*;



void setup(){
  size(600,300,OPENGL);
  Anar.init(this);

  Anar.drawAxis(true);
  Pts.globalRender = new RenderPtsAll();

  createForm();
}

Obj form;

void createForm(){
  form = new Obj();    //Create an empty Object

  Pts myList  = new Pts();
  Pts myList2 = new Pts();

  for(int i=0; i<20; i++)
  {
    Pt p;

    p = Anar.Pt(i*10,i*i,0);
    myList.add(p);

    p = Anar.Pt(-i*10,i*i,0);
    myList.add(p);
  }

  form.add(myList);
  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
