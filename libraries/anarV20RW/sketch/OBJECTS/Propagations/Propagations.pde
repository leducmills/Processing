import processing.opengl.*;
import anar.*;

Anar     Anar;
Obj     myObj;

Sliders rotations = new Sliders();
Sliders global    = new Sliders();

Sliders display;

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  myObj = new Obj();

  // ORGINAL STARTING PARAMETERS
  Pt origin = Anar.Pt(0,0,0);

  Param w = new Param(30);
  Param h = new Param(40);
  global.add(w);
  global.add(h);

  // CREATE AN ARRAY OF PARAM
  Param[][] individualRotations = new Param[20][10];

  for (int i = 0; i<individualRotations.length; i++)
    for (int j = 0; j<individualRotations[i].length; j++){
      Param moduleRotation = new Param(0);
      individualRotations[i][j] = moduleRotation;
      rotations.add(moduleRotation);
    }


  // PROPAGATE SOME LOCAL TRANSFORMATIONS TO INDIVIDUALROTATIONS SET
  for(int i=0; i<20; i++)
  {
    int onCol = Anar.rndi(individualRotations[0].length);
    int onRow = Anar.rndi(individualRotations.length);
    int nOpen = Anar.rndi(1,7);
    int nSustain = Anar.rndi(1,7);

    individualRotations = propagateValue(individualRotations,onCol,onRow,nOpen,nSustain,nOpen);

  }

  //    individualRotations = propagateValue(individualRotations,0,0,3,3,3);
  //    individualRotations = propagateValue(individualRotations,0,1,3,3,3);


  // CREATE MODULES WITH RESULTING ROTATIONS
  for (int i = 0; i<individualRotations.length; i++)
    for (int j = 0; j<individualRotations[i].length; j++){
      Pt a = Anar.Pt(origin,new Translate(new ParamMul(i,w),new ParamMul(j*2,h)));
      myObj.add(createModule(a,w,h,individualRotations[i][j]));
    }

  // SCENE RELATED STUFF
  display = global;
  Anar.camTarget(myObj);
}


// CREATE A MODULE OF WxH DIMENSIONS WITH ROTATIONAL FACTOR
Obj createModule(Pt origin, Param w, Param h, Param p){
  Obj output = new Obj();

  Face a = new Rect(w,h);
  Transform t = new Transform(a.pt(2),a.pt(3),new RotateX(p));
  a.apply(t);

  Face b = new Face(a,new MirrorY());

  output.add(a);
  output.add(b);
  output.translate(origin);

  return output;
}



Param[][] propagateValue(Param[][] oldSet, int colomn, int rowStart, int nOpen, int nSustain, int nClose){

  Param propagateCf = new Param(0,0,1);
  global.add(propagateCf);

  int startIndex = rowStart;

  // FIRST CONDITION
  float deltaA = 1/(float)nOpen;
  for (int i = 0; i<nOpen; i++){
    int row = i+startIndex;

    if(oldSet.length>row){
      Param propagator = new ParamMul(propagateCf,(i)*deltaA);
      oldSet[row][colomn] = new ParamSum(oldSet[row][colomn],propagator);
    }
  }
  startIndex += nOpen;


  // SECOND CONDITION
  for (int i = 0; i<nSustain; i++){
    int row = i+startIndex;

    if(oldSet.length>row){
      // Param propagator = new ParamMul(propagateCf,(i-openA)*deltaA);
      oldSet[row][colomn] = new ParamSum(oldSet[row][colomn],propagateCf);
    }
  }
  startIndex += nSustain;


  // THIRD CONDITION
  float deltaB = 1/(float)nClose;
  for (int i = 0; i<nClose; i++){
    int row = i+startIndex;

    if(oldSet.length>row){
      Param propagator = new ParamMul(propagateCf, (nClose-i-1)*deltaB);
      oldSet[row][colomn] = new ParamSum(oldSet[row][colomn],propagator);
    }
  }
  return oldSet;
}




void draw(){
  background(155);
  myObj.draw();

  if(display!=null)
    display.draw();
}


// SWITCH BETWEEN DIFFERENT SET OF SLIDERS
void keyPressed(){
  if(key==' ')
    if(display==global)
      display = rotations;
  // else
  // if(display==rotations)
  // display = rotationsResults;
    else
      display = global;
}
