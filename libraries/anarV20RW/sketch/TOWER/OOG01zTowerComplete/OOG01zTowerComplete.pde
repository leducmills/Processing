import anar.*;
import processing.opengl.*;

Anar     Anar;

Obj     towerCore         = new Obj();
Obj     contourLines      = new Obj();
Obj     verticalLines     = new Obj();
Obj     windows           = new Obj();
Obj     structure         = new Obj();
Obj     rooms             = new Obj();

Obj     export        = new Obj();

//Sliders mySliders;


void setup(){
  size(800,400,OPENGL);
  Anar.init(this);

  // Setup DEFAULT rendering of our scene
  Anar.drawAxis(true);

  initForm();
}


void initForm(){

  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // Initial SHAPE

  // Here, we create an arbitrary shape
  Face iShape;
  iShape = new Star(100,50,5);


  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // LEVEL

  // The initial shape is duplicated Applying always the same predefined
  // Transformation

  Param numOfSubDivisionsOnEachSides = new Param(6);

  Transform combo = new Transform();
  combo.translate(0,0,5);
  combo.scale(0.92f,0.945f,1.04f);
  combo.rotateZ(.06f);

  for (int i = 0; i<24; i++){
    Face floorShape = new Face(iShape,combo);
    towerCore.add(floorShape);
    iShape = floorShape;
  }

  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // VERTICALES

    for (int i = 0; i<towerCore.numOfFaces(); i++){
      Face shape = towerCore.face(i);

      Pts contour;
      Pts tmpPtList = new Pts();

      for (int j = 0; j<shape.size(); j++){
        int jj = (j+1)%shape.size();
        contour = new PtsMid(shape.pt(j),shape.pt(jj),numOfSubDivisionsOnEachSides);
        contour.remove(contour.size()-1); // Remove the last one from the set
        tmpPtList.addPointsFrom(contour);
      }

      contourLines.add(tmpPtList);
    }



    int nodesPerLevel = contourLines.line(0).size();

    for (int j = 0; j<nodesPerLevel; j++){
      if(j%3!=0){
        Pts tmpPtList = new Pts();
        for (int i = 0; i<contourLines.numOfLines(); i++){
          Pts a = contourLines.getLine(i);
          tmpPtList.add(a.get( (j+1*i)%nodesPerLevel));
        }
        verticalLines.add(tmpPtList);
      }
    }


  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // WINDOWS

  Param offset1 = new Param(.05f);
  Param offset2 = new Param(.5f);
  Param ratioI = new Param(8);


    for (int i = 1; i<verticalLines.numOfLines(); i += 2){
      Pts a = verticalLines.line(i);
      Pts b = verticalLines.line( (i+1)%verticalLines.numOfLines());

      for (int j = 0; j<a.size()-1; j++){
        Pts k = new PtsMid(a.pt(j),a.pt(j+1),ratioI);
        Pts l = new PtsMid(b.pt(j),b.pt(j+1),ratioI);

        Pt aa = k.pt(1);
        Pt bb = a.pt(j+1);
        Pt cc = b.pt(j+1);
        Pt dd = l.pt(1);

        PtNormal nn = new PtNormal(aa,bb,cc,offset1);
        PtNormal kk = new PtNormal(bb,cc,dd,offset2);
        PtNormal mm = new PtNormal(cc,dd,aa,offset2);
        PtNormal ll = new PtNormal(dd,aa,bb,offset1);

        Pts c;

        c = new Pts();
        c.add(bb);
        c.add(nn);

        c = new Pts();
        c.add(dd);
        c.add(mm);

        Face f = new Face();
        f.add(nn);
        f.add(kk);
        f.add(mm);
        f.add(ll);
        windows.add(f);
      }
    }



  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // STRUCTURE

  Obj pointsOnFloors = new Obj();

  for (int i = 0; i<towerCore.numOfFaces(); i++){
    Pts structureLine = new Pts();
    Face shape = towerCore.face(i);
    // structureLine.add(p);

    for (int j = 0; j<shape.numOfPts(); j++){
      float[] w;
      PtBary q;

      w = new float[shape.size()];
      w[j] = .5f;
      w[(j+1)%shape.numOfPts()] = .2f;
      q = new PtBary(shape,w);
      structureLine.add(q);

      w = new float[shape.size()];
      w[j] = .5f;
      w[ (j-1+shape.numOfPts())%shape.numOfPts()] =.2f;
      q = new PtBary(shape,w);
      structureLine.add(q);

      w = new float[shape.size()];
      w[j] = .3f;
      w[ (j-1+shape.numOfPts())%shape.numOfPts()] = .15f;
      q = new PtBary(shape,w);
      structureLine.add(q);        

      w = new float[shape.size()];
      w[j] = .3f;
      w[(j+1)%shape.numOfPts()] = .15f;
      q = new PtBary(shape,w);
      structureLine.add(q);        
    }

    pointsOnFloors.add(structureLine);
  }


  for (int i = 0; i<pointsOnFloors.numOfLines()-1; i++){
    Pts q = pointsOnFloors.line(i);
    Pts r = pointsOnFloors.line(i+1);
    for (int j = 0; j<q.size(); j += 4){
      Face p;

      for (int k = 0; k<4; k++){
        p = new Face();
        p.add(q.pt(j+k));
        p.add(r.pt(j+k));
        p.add(r.pt( (j+(k+1)%4)));
        p.add(q.pt( (j+(k+1)%4)));
        structure.add(p);
      }
    }
  }



  // //////////////////////////////////////////
  // //////////////////////////////////////////
  // Rooms

  RenderFaceDefault fRender = new RenderFaceDefault(new AColor(255,0,0,100));

  pointsOnFloors = new Obj();

  for (int i = 0; i<towerCore.numOfFaces(); i++){
    Pts structureLine = new Pts();
    Face shape = towerCore.face(i);

    for (int j = 0; j<shape.numOfPts(); j++){
      float[] w = new float[shape.size()];
      w[j] = 0.8f;
      PtBary q = new PtBary(shape,w);
      structureLine.add(q);     
    }

    pointsOnFloors.add(structureLine);
  }


  for (int i = 0; i<pointsOnFloors.numOfLines()-1; i+=2){
    Pts q = pointsOnFloors.line(i);
    Pts r = pointsOnFloors.line(i+1);
    for (int j = 0; j<q.size(); j ++){
      Face p;

      p = new Face();
      p.add(q.pt(j));
      p.add(r.pt(j));
      p.add(r.pt( ((j+1)%q.size())));
      p.add(q.pt( ((j+1)%q.size())));
      p.render = fRender;

      rooms.add(p);


    }
  }    



  // //////////////////////////////////////////
  // HIRARCHY

  Anar.camTarget(towerCore);
  //mySliders = new Sliders(structure);

  // Store All objects in one group
  //    export.add(towerCore);
  //    export.add(verticalLines);
  export.add(windows);
  //    export.add(structure);
  //    export.add(rooms);
  
  Anar.sliders(towerCore);

}


void draw(){
  background(200);

  towerCore.draw();
  verticalLines.draw();
  // contourLines.draw();
  windows.draw();
  structure.draw();
  rooms.draw();

  //mySliders.draw();
}




void keyPressed(){

  switch(key){
  case 'r':
    //RhinoScript.export(export,this.getClass().getSimpleName());
    break;
  case 's':
    //SketchUpRuby.export(export,this.getClass().getSimpleName());
    break;
  case ' ':
    //initForm();
    break;    
  }
}
