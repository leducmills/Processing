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

  for(int i=0; i<80; i++)
  {
    myList.add(Anar.Pt( i*10,sin(i/3.0f)*30,0));
  }
  
  form.add(myList);
  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
