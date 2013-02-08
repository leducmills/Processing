import anar.*;
import processing.opengl.*;

Anar     Anar;

Obj     towerCore         = new Obj();
Obj     windows           = new Obj();
Obj     structure         = new Obj();
Obj     rooms             = new Obj();

Sliders myDiscoSliders = new Sliders();

public void setup(){
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
  // STRUCTURE

  Obj pointsOnFloors = new Obj();

  for (int i = 0; i<towerCore.numOfFaces(); i++){
    Pts structureLine = new Pts();
    Face shape = towerCore.face(i);
    // structureLine.add(p);

    for (int j = 0; j<shape.numOfPts(); j++){
      float[] w;
      PtBaryRedux q;

      w = new float[shape.size()];
      w[j] = 3.5f;
      w[(j+1)%shape.numOfPts()] = .2f;
      q = new PtBaryRedux(shape,w);
      structureLine.add(q);

      w = new float[shape.size()];
      w[j] = 3.5f;
      w[ (j-1+shape.numOfPts())%shape.numOfPts()] =.2f;
      q = new PtBaryRedux(shape,w);
      structureLine.add(q);

      w = new float[shape.size()];
      w[j] = 2.3f;
      w[ (j-1+shape.numOfPts())%shape.numOfPts()] = .15f;
      q = new PtBaryRedux(shape,w);
      structureLine.add(q);        

      w = new float[shape.size()];
      w[j] = 2.3f;
      w[(j+1)%shape.numOfPts()] = .15f;
      q = new PtBaryRedux(shape,w);
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
      PtBaryRedux q = new PtBaryRedux(shape,w);
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
  myDiscoSliders.add(towerCore);

}


boolean imRecording = false;

public void draw(){
  background(200);

  towerCore.fill(0,255,0);

  towerCore.draw();
  structure.draw();
  rooms.draw();
  
  updateParam();
  
  if(imRecording)
   saveFrame("tower####.tga"); 
}


void keyPressed(){
 imRecording = !imRecording;
 println("isRecording: "+imRecording);
}

void updateParam(){
  myDiscoSliders.get(0).set(100*sin(frameCount/10f));
  myDiscoSliders.get(2).set(100*sin(frameCount/33f));
  println(myDiscoSliders.get(0));
}

