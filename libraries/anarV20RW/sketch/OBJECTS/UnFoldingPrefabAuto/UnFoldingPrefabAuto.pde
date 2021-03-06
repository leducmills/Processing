import anar.*;
import processing.opengl.*;


Obj             myObject;

Param angle    = new Param(0.3f);
Param invAngle = new Param( -angle.get());

///////////////////////////////////
///////////////////////////////////
///////////////////////////////////

void setup(){

  //size(screen.width,screen.height,OPENGL);
  size(1000,500,OPENGL);
  Anar.init(this);
  Anar.drawAxis(true);

  myObject = generatorDeploy();
  Face.globalRender = new RenderFaceDoubleSide(new AColor(255,180,180),new AColor(220));
}

///////////////////////////////////
///////////////////////////////////
///////////////////////////////////  


public void draw(){
  if(frameCount%2==0) background(255);
  else background(254);

  myObject.draw();

  /*
     if(frameCount%1000==750){
   angle.set(0);
   invAngle.set( -angle.get());
   }
   if(frameCount%1000==999){
   angle.set(0.3f);
   invAngle.set( -angle.get());
   }*/

  angle.set(angle.get()+0.01f);
  invAngle.set( -angle.get());
}


public void keyPressed(){

  switch(key){
  case ' ':
    myObject = generatorDeploy();
    break;
  case 'q':
    angle.set(0);
    invAngle.set( -angle.get());
    break;
  case 'w':
    angle.set(0.3f);
    invAngle.set( -angle.get());
    break;
  }

}

///////////////////////////////////
///////////////////////////////////
///////////////////////////////////

Obj generatorDeploy(){

  ///////////////////////////////////
  ///////////////////////////////////
  //INIT SOME CONTAINERS
  Obj outputFmz = new Obj();

  ///////////////////////////////////    
  ///////////////////////////////////
  //PREPARE TRANSFORMS

  //We limit the set of transforms to three different
  //    It will produce a limited set of different patterns

  //The elementary operation
  Translate modulor = new Translate(Anar.PtNull(0,0,1));


  //Create 3 subsequent Transform from this one
  //  I use TransformLinear to combine them as a group
  Transform side0 = new Transform();
  side0.add(modulor);

  Transform side1 = new Transform();
  side1.add(modulor);
  side1.add(modulor);

  Transform side2 = new Transform();
  side2.add(modulor);
  side2.add(modulor);
  side2.add(modulor);

  //Then I have three different transforms from the first one
  //  They have different lengths
  //  Remark, I ends up with only one parameter

    //Combine them in a table (it will be usefull when randomized)
  //    Here I need to remember that 0 is short, 1 normal and 2 is long
  Transform[] sides = new Transform[3];
  sides[0] = side0;
  sides[1] = side1;
  sides[2] = side2;

  //It's good for sides
  //    Now let's create a rotation (let's keep it simple with only one rotation)
  //    On the chantier, it correspond to uniforms clips between panels

  //I need to create a RotateZ as it will be used inside Allingn
  //    Allign will allign an axis to Z coordinate then apply a transform and Come back to initial state
  RotateZ myRotation = new RotateZ(angle);
  RotateZ myInvRotation = new RotateZ(invAngle);

  Transform rotation_2 = new Transform();
  rotation_2.add(myInvRotation);
  rotation_2.add(myInvRotation);

  Transform rotation_1 = new Transform();
  rotation_1.add(myInvRotation);

  Transform rotation0 = new Transform();

  Transform rotation1 = new Transform();
  rotation1.add(myRotation);

  Transform rotation2 = new Transform();
  rotation2.add(myRotation);
  rotation2.add(myRotation);

  Transform[] rotations = new Transform[5];
  rotations[0] = rotation_2;
  rotations[1] = rotation_1;
  rotations[2] = rotation0;
  rotations[3] = rotation1;
  rotations[4] = rotation2;

  ///////////////////////////////////    
  ///////////////////////////////////
  //ASSIGN TRANSFORMS    

  //I<ll create to lines and combine them later    
  Pts ptsA = new Pts();
  Pts ptsB = new Pts();

  //I need two initial points
  //    This is where I set the side length of the whole thing
  Pt originA = Anar.Pt(0,0,0,"originA");
  Pt originB = Anar.Pt(0,10,0,"originB");

  //Add them to the list
  ptsA.add(originA);
  ptsB.add(originB);

  //(Update) We need those POints to orient the translation
  PtDER originAA = Anar.Pt(originA);
  PtDER originBB = Anar.Pt(originB);

  originAA.set(sides[0]);
  originBB.set(sides[0]);

  //Add them to the list
  ptsA.add(originAA);
  ptsB.add(originBB);


  //As the form is an inerplay between aNewPoint and a previousPt
  //    I<ll create two fields to track them
  //    Note, it's not derrived, it is the point itself (Pt previousA = Anar.Pt(originA))
  Pt previousA = originAA;
  Pt previousB = originBB;

  Pt previousAA = originA;
  Pt previousBB = originB;

  //Ineed also to track the difference between both (number of times betweens modulos)
  //    At the beginning they are both alligns
  //    -1 means that ptsB is from a distance 1 of modulor less than ptsA
  //     2 means that ptsB is from a distance 2 of modulor more than ptsA
  int delta = 0;

  for (int i = 0; i<300; i++){
    //Create a points from previous (i label them - optional)
    PtDER newPtA = Anar.Pt(previousA,"A"+i);
    PtDER newPtB = Anar.Pt(previousB,"B"+i);

    //Choose one translations from our set.
    //    (we won't accept delta to be too long as we want to keep the set of faces to a small set of cases
    int lengthA, lengthB; //Correspond to sides[0,1,2]

    do{
      lengthA = (int)random(sides.length);
      lengthB = (int)random(sides.length);
    } 
    while (Math.abs(lengthA-lengthB+delta)>3); //Here I limit the maximum sitance between paths (both ways)

    //Update new delta state
    delta += lengthA-lengthB;

    //Create Rotation from an axis (eachPoint is different
    //    allign need an axis of rotation (defined here by the two old resulting points (previuos)
    //    axis = previousA,previousB
    Transform rotmp = rotations[(int) ((float)Math.random()*rotations.length)];

    Transform axisRotateA = new Transform(previousA,previousB,rotmp);
    Transform axisRotateB = new Transform(previousA,previousB,rotmp);


    //Create a Translation alligned with the previous
    //    Remember that we don't know how is oriented the last face
    Transform orientedTranslationA = new Transform(previousAA,previousA,sides[lengthA]);
    Transform orientedTranslationB = new Transform(previousBB,previousB,sides[lengthB]);


    //Apply to rotation to the translation
    Transform comboA = new Transform();
    comboA.add(orientedTranslationA);
    comboA.add(axisRotateA); //From the beginning


    Transform comboB = new Transform();
    comboB.add(orientedTranslationB);
    comboB.add(axisRotateB); //From the beginning        

    //Here's where evrything is set together pt with transform
    newPtA.set(comboA);
    newPtB.set(comboB);

    //Alternative (if we don't want to apply the rotation
    //    Use this to see only the translation effect  on a plane    
    //newPtA.set(sides[lengthA]);
    //newPtB.set(sides[lengthB]);      

    //Put all that in that containers
    ptsA.add(newPtA);
    ptsB.add(newPtB);

    //Swap Previuos
    previousAA = previousA;
    previousBB = previousB;

    previousA = newPtA;
    previousB = newPtB;
  }


  ///////////////////////////////////    
  ///////////////////////////////////
  //RETURN EVRYTHING

  //cREATE FACES FROM TWO LINES WITH SAME NUMBERS OF POINTS
  outputFmz = Obj.sweepFromTwoPaths(ptsA,ptsB);
  return outputFmz;
}

/**
 * container class for each element of the deployment
 */
class Element {

  int   A, B;
  float energy;

  Element(int _A, int _B, float _e){
    A = _A;
    B = _B;
    energy = _e;
  }
}

