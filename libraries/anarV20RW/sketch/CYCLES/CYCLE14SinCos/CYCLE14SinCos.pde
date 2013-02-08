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

  for(int i=0; i<80; i++)
  {
    myList.add(Anar.Pt( i*10,sin(i/3.0f)*30,0));
    myList2.add(Anar.Pt( i*10,cos(i/3.0f)*30,30));
  }

  for(int i=0; i<myList.numOfPts()-1; i++)
  {
    Face myFace = new Face();
    
    myFace.add(myList.pt(i));   
    myFace.add(myList.pt(i+1));   
    myFace.add(myList2.pt(i+1));   
    myFace.add(myList2.pt(i));  
  
    form.add(myFace);  
  }

  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
