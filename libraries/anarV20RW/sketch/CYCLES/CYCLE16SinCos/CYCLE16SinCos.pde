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

int bump = 10;
int moduleHeight = 50;

void createForm(){
  form = new Obj();    //Create an empty Object

  Pts myList;
  Pts myList2;

  for(int j=0; j<10; j++)
  {

    myList = new Pts();
    myList2 = new Pts();

    for(int i=0; i<80; i++)
    {
      myList.add(Anar.Pt( i*10,sin(i/3.0f)*bump,moduleHeight*(j*2)));
      myList2.add(Anar.Pt( i*10,cos(i/3.0f)*bump,moduleHeight*(j*2+1)));
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

    /////////////////////////////////////
    /////////////////////////////////////

    myList = new Pts();
    myList2 = new Pts();

    for(int i=0; i<80; i++)
    {
      myList.add(Anar.Pt( i*10,cos(i/3.0f)*bump,moduleHeight*(j*2+1)));
      myList2.add(Anar.Pt( i*10,sin(i/3.0f)*bump,moduleHeight*(j*2+2)));
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

  }

  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
