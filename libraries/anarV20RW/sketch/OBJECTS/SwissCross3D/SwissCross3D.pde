import anar.*;





Obj myObj;
Param w1 = new Param(50,20,100);
Param w2 = new Param(50,20,100);

void setup(){
  size(300,300,P3D);
  Anar.init(this);
  Anar.scene.lights = false;
  Anar.scene.autoRotateZ = .01f;
  Anar.scene.autoRotateX = .0041;
  
//    Anar.sliders(w1);
//    Anar.sliders(w2);

  initForm();
}

void initForm(){
  myObj = new Obj();
  Obj swissCross3D = new SwissCross3D(w1,w2);
  swissCross3D.fill(new RenderFaceNoStroke(new AColor(255)));
  myObj.add(swissCross3D);
}

void draw(){
  background(215,0,0);
  myObj.draw();
  
  if (key == ' ') {
    w1.setNormalized(mouseX/(float)width);
    w2.setNormalized(mouseY/(float)height);
  }
}

