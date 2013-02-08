import anar.*;


import processing.opengl.*;
import anar.*;



void setup(){
  size(600,300,OPENGL);
  Anar.init(this);

  createForm();
}

Obj form;

void createForm(){
  form = new Obj();    //Create an empty Object

  //////////////////////////////////////
  //CREATE A BASIC GRID

  Obj tmpObject = new Obj();

  for(int i=0; i<60; i++)
  {
    Pts myList  = new Pts();

    for(int j=0; j<60; j++)
      myList.add(Anar.Pt( i*10,j*10,0));

    tmpObject.add(myList); 
  }

  //////////////////////////////////////
  //CREATE LINE S FROM A GRID USING MODULO

  for(int i=0; i<tmpObject.numOfLines(); i++)     //For each Lines
    if(i%3!=0)                                    //Skip the third line
    {
      Pts myList  = new Pts();                  //Container fpr new Points

      for(int j=0; j<tmpObject.line(i).numOfPts()-1; j+=2)       //For each points of this line
      {
        int indexOfLine  = (i+1)%tmpObject.numOfLines();
        int indexOfPoint = (j+1)%tmpObject.line(i).numOfPts();
        myList.add(tmpObject.line(i).pt(j));
        myList.add(tmpObject.line(indexOfLine).pt(indexOfPoint));
      }

      form.add(myList);                           //Add the new Pts to form obj()
    }

  Anar.camTarget(form);
}

void draw(){
  background(255);
  form.draw();
}
