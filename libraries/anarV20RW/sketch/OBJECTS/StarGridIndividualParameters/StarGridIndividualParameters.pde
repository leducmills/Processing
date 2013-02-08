import processing.opengl.*;
import processing.opengl.*;
import anar.*;





Obj myObj = new Obj();

Sliders hauteurs = new Sliders();
Sliders rotationz = new Sliders();

Obj[][] griOfPyr = new Obj[6][6];


void setup(){
  size(800,400,OPENGL);
  frameRate(200);

  //this.hint(ENABLE_OPENGL_2X_SMOOTH);

  Anar.init(this);
  Anar.drawAxis(true);

  initForm();


  //Anar.sliders(griOfPyr[0][0]);

  actualDisplayedSet = hauteurs;
}


void initForm(){

  myObj = new Obj();

  int nGridX = 6;
  int nGridY = 6;

  Param h = new Param(30,0,300);
  Param r = new Param(1,-PI*4,PI*4);
  Param L = new Param(50,0,100);
  Param s = new Param(20,0,100);

  /*
  Anar.slidersReset();
   Anar.sliders(h);
   Anar.sliders(r);
   Anar.sliders(L);
   Anar.sliders(s);
   */

  for(int i=0; i<nGridX; i++)
    for(int j=0; j<nGridY; j++){       
      Param x = s.multiply(nGridX*(i-nGridX/2f));
      Param y = s.multiply(nGridY*(j-nGridY/2f));

      Obj tmpModule = createModule(x,y,h,random(90)+10,L,(int)random(10)+3,r);

      myObj.add(tmpModule);

      griOfPyr[i][j] =  tmpModule;
    }

  myObj.fill(255,100);
}


Obj createModule(Param x, Param y,Param h,float lengthA, Param lenghtB, int numOfSides, Param rotation){
  Obj myModule = new Obj();    

  Face star = new Star(new Param(lengthA),lenghtB,new Param(numOfSides));
  star.translate(x,y);


  Param hh = new Param(.5f); 
  hauteurs.add(hh);

  Param rr = new Param(.5f); 
  rotationz.add(rr);

  Obj pyr = new Pyramid(star,hh);
  myModule.add(pyr);

  Transform allign = new Transform(star.pt((int)random(star.numOfPts())),star.pt((int)random(star.numOfPts())));
  allign.rotateZ(rr);

  Face starRefelx = new Face(star,allign);

  myModule.add(starRefelx);

  return myModule;
}


Sliders actualDisplayedSet;

void draw(){
  background(155);
  myObj.draw();
  actualDisplayedSet.draw();


}


void keyPressed(){
  if(actualDisplayedSet == hauteurs)
    actualDisplayedSet = rotationz;
  else 
    actualDisplayedSet = hauteurs;
}


