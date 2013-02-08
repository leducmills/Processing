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

  //////////////////////////////////////
  //CREATE A BASIC GRID

  Obj tmpObject = new Obj();

  for(int i=0; i<30; i++)
  {
    Pts myList  = new Pts();

    for(int j=0; j<20; j++)
      myList.add(Anar.Pt( i*10,j*10,0));

    tmpObject.add(myList); 
  }

  //////////////////////////////////////
  //CREATE LINE S FROM A GRID USING MODULO

  for(int i=0; i<tmpObject.numOfLines(); i++)     //For each Lines
    if(i%3!=0)                                    //Skip the third line
    {
      Pts myList  = new Pts();                  //Container fpr new Points
      
      Pts iLine = tmpObject.line(i);             //Create a temp line

      for(int j=0; j<iLine.numOfPts(); j++)       //For each points of this line
        myList.add(iLine.pt(j));
          //myList.add(tmpObject.line(i).pt(j));
          //(Alternative way to access the point directly inside the line)

      form.add(myList);                           //Add the new Pts to form obj()
    }

  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
