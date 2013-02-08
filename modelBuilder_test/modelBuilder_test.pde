import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

MouseNav3D nav;

UGeometry model;
UVertexList vl;

void setup() {
  size(400, 400, P3D);
  vl=new UVertexList();
  model = new UGeometry();
  // add MouseNav3D navigation
  nav=new MouseNav3D(this);
  nav.trans.set(width/2, height/2, 0);
  buildModel();
  smooth();
}

void draw() {
  background(100);

  lights();

  // call MouseNav3D transforms
  nav.doTransforms();
  fill(255, 100, 0);
  //buildModel();
  //vl.drawQuadStrip(this);
  model.draw(this);
}

public void mouseDragged() {
  nav.mouseDragged();
}

public void keyPressed() {
  nav.keyPressed();

  if (key=='s') {
    model.writeSTL(this, selectOutput());
  }
}

