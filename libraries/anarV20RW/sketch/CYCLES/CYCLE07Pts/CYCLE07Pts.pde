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
  
  Pts myList = new Pts();
  
  for(int i=0; i<30; i++)
    {
      Pt p = Anar.Pt(i*10,i*i,0);
      myList.add(p);
    }
  
  form.add(myList);
}

void draw(){
  background(255);
  form.draw();
}
