import processing.opengl.*;
import anar.*;


Obj myObj;

Group group = new Group();

void setup(){
  size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  Face.globalRender = new RenderFaceNormal(new AColor(255,100),new AColor(100));

  initForm();
}

void initForm(){
  myObj = new Obj();



  /////////////////////////////////////
  //CONE
  /////////////////////////////////////
  Obj cone = new Cone(50,100,20);
  cone.set("cone");
  cone.translate(100,100,0);

  println(cone.toObjExporter());
  group.add(cone);



  /////////////////////////////////////
  //BOX
  /////////////////////////////////////
  Obj box = new Box(10,20,30);
  box.set("box");
  box.rotateZ(0);
  box.rotateX(0);
  box.translate(100,0,0);

  println(box.toObjExporter("box"));
  println(box.parentList(-1));
  group.add(box);



  /////////////////////////////////////
  //CYLINDER
  /////////////////////////////////////
  Obj cylinder = new Cylinder(50,24,50);
  cylinder.set("cylinder");
  cylinder.translate(-100,0,0);

  println(cylinder.toObjExporter("cylinder"));
  group.add(cylinder);



  /////////////////////////////////////
  //ELLIPSE
  /////////////////////////////////////
  Face ellipse = new Ellipse(40,20);
  ellipse.set("ellipse");

  println(ellipse.toObjExporter("ellipse"));
  group.add(ellipse);



  /////////////////////////////////////
  //SWISSCROSS3D
  /////////////////////////////////////
  Obj swissCross3D = new SwissCross3D(10,10);
  swissCross3D.set("swissCross3D");
  //swissCross3D.fill(255,0,0,200);
  println(swissCross3D.toObjExporter("swissCross3D"));
  //swissCross3D.translate(-100,0,0);
  group.add(swissCross3D);



  /////////////////////////////////////
  //REVOLVER
  /////////////////////////////////////
  Pts ctrlRevol = new Pts();
  ctrlRevol.add(Anar.Pt(30,0,30));
  ctrlRevol.add(Anar.Pt(10,0,40));
  ctrlRevol.add(Anar.Pt(20,0,60));
  ctrlRevol.add(Anar.Pt(20,0,70));

  Obj revolver = new Revolve(ctrlRevol, Anar.Pt(0,0,20),12);    
  revolver.set("revolver");

  println(revolver.toObjExporter("revolver"));
  group.add(revolver);


  ////////////////////////////////////
  ///////////////////////////////////// 
  myObj.add(box);
  myObj.add(cone);
  myObj.add(cylinder);
  myObj.add(ellipse);
  myObj.add(swissCross3D);
  myObj.add(revolver);



  Anar.sliders(swissCross3D);
  Anar.sliders(revolver);
  Anar.camTarget(revolver);
  
  //font = loadFont("ATRotisSemiSans-48.vlw");
}

PFont font;

void draw(){
  background(155);
  group.draw();
}

void keyPressed(){
  if(key==' ') initForm();

  if(key=='a') Autolisp.export(myObj,"myExport");
  if(key=='f') RhinoScript.export(myObj,"myExport");
  if(key=='s') SketchUpRuby.export(myObj,"myExport");
  if(key=='p') PovRAY.export(myObj,"myExport");
  if(key=='o') ObjExporter.export(group,"myExport");
}

