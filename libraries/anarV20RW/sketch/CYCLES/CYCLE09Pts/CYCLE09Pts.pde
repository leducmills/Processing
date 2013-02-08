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
    myList.add(Anar.Pt( i*10,i*i,0));
    myList.add(Anar.Pt(-i*10,i*i,0));
    myList2.add(Anar.Pt( i*10,i*i,30));
    myList2.add(Anar.Pt(-i*10,i*i,30));
  }

  form.add(myList);
  form.add(myList2);
  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
