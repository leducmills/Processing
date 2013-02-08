import processing.opengl.*;
import anar.*;


Obj myObj;

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  myObj = new Obj();
  Anar.slidersReset();

  // BUILDING CURVES
  Pts ctrlc1 = new Pts();
  for (int i = 0; i<10; i++)
    ctrlc1.add(Anar.Pt(i*20,random(50),0));
  ctrlc1.stroke(165);

  Pts ctrlc2 = new Pts();
  for (int i = 0; i<10; i++)
  {
    TranslateY ty = new TranslateY(Anar.rnd(50));
    ctrlc2.add(Anar.Pt(ctrlc1.pt(i),ty));
    Anar.sliders(ty);
  }
  ctrlc2.stroke(165);

  myObj.add(ctrlc1);
  myObj.add(ctrlc2);

  // BUILDING CURVES
  CSpline cc1 = new CSpline(ctrlc1,5);
  CSpline cc2 = new CSpline(ctrlc2,5);

  Pts c1 = cc1.getPts(100);
  Pts c2 = cc2.getPts(100);

  //Pts c1 = ctrlc1.asCurve(100);
  //Pts c2 = ctrlc2.asCurve(100); 

  // c1.stroke(100,100,240);
  // c2.stroke(100,100,240);
  c1.stroke(240,100,100,240);
  c2.stroke(240,100,100,240);


  myObj.add(c1);
  myObj.add(c2);


  myObj.add(divideCurve(c1,c2,0,0));


  Anar.camTarget(myObj);
}


Obj divideCurve(Pts c1, Pts c2, int i1, int i2){
  Obj result = new Obj();

  Obj subResult = new Obj();

  int mx = min(c1.numOfPts()-i1,c2.numOfPts()-i2);

  //println("mx:"+mx+" c1:"+c1.numOfPts()+"/"+i1+" c2:"+c2.numOfPts()+"/"+i2);

  Pts sub = new Pts();

  for (int i = 0; i<mx; i++){
    int ii1 = i1+i;
    int ii2 = i2+i;

    Pt a1 = c1.pt(ii1);
    Pt b1 = c2.pt(ii2);

    // SUBSAMPLING BEFORE
    Pt a0, b0;

    if(ii1-1>=0)
      a0 = c1.pt(ii1-1);
    else
      a0 = c1.pt(ii1);

    if(ii2-1>=0)
      b0 = c2.pt(ii2-1);
    else
      b0 = c2.pt(ii2);

    // SUBSAMPLING AFTER
    Pt a2, b2;

    if(ii1+1<c1.numOfPts())
      a2 = c1.pt(ii1+1);
    else
      a2 = c1.pt(ii1);

    if(ii2+1<c2.numOfPts())
      b2 = c2.pt(ii2+1);
    else
      b2 = c2.pt(ii2);

    // CALCULATE THE THRESHOLD LENGTH
    // (in this case it's based on surrounding points)
    float len = (Pt.length(a0,b0)+Pt.length(a1,b1)+Pt.length(a2,b2))/3;
    // float len = Pt.length(a1,b1);

    // DISPLAY REDLINES (Sampling lines)
    if(random(1)<0.1f){
      Pts debug = new Pts();
      debug.add(a1);
      debug.add(b1);
      debug.stroke(145);
      subResult.add(debug);
    }

    // IF THE TRESHOLD IF BIGGER THAN LIMIT HERE
    // SUBDIVIDE.
    // OTHERWISE, DO THE RECURSION
    float treshold = 4;

    if(len>treshold){
      if(len>treshold*2)
        sub.add(new PtMid(a1,b1,3,1));
      else
        sub.add(new PtMid(a1,b1,2,1));
    }
    else

        if(sub.numOfPts()>0){
        // sub.reverse();

        subResult.add(sub);

        Obj recurs = new Obj();
        recurs.add(divideCurve(sub,c1,0,ii1-sub.numOfPts()));
        recurs.add(divideCurve(sub,c2,0,ii2-sub.numOfPts()));
        // recurs.add(divideCurve(c1,sub,i+i1,0));


        subResult.add(recurs);

        sub = new Pts();
        //sub.add(a1);
      }
  }

  if(sub.numOfPts()>1){
    // sub.reverse();
    subResult.add(sub);

    Obj recurs = new Obj();
    recurs.add(divideCurve(sub,c1,0,c1.numOfPts()-sub.numOfPts()));
    recurs.add(divideCurve(sub,c2,0,c2.numOfPts()-sub.numOfPts()));

    subResult.add(recurs);
    sub = new Pts();
  }


  return subResult;
}



void draw(){
  background(155);
  myObj.draw();
}

void keyPressed(){
  if(key==' ')
    initForm();
  if(key=='s')
    saveFrame("screnshot###.jpg");
}
