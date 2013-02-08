public void animation() {

  if(v2.x > 0 && v2.y > 0) {  //lower right
    downRight();
  }
  else if (v2.x > 0 && v2.y < 0) { //upper right
    upRight();
  }
  else if (v2.x < 0 && v2.y < 0) { //upper left
    upLeft();
  }
  else if (v2.x < 0 && v2.y > 0) { //lower left
    downLeft();
  }
}

// float k = 0.0;
public void upLeft() {
  //println("upper left");
  //scale
  for(int i = 0; i < model.getVertexCount(); i++) {
    PVector orgv = model.getVertex(i);
    PVector tmpv = new PVector();
    tmpv.x = orgv.x * abs(v2.x * .01);
    tmpv.y = orgv.y * abs(v2.y * .01);
    tmpv.z = orgv.z;
    
    //println(tmpv.x + " " + tmpv.y);
    
    if (tmpv.x > -2 && tmpv.y > -2) {
    
    tmpmodel.setVertex(i, tmpv);
    //println(tmpmodel.getVertex(i));
    }
  }

  //need to fix persistence for scaling


  //k+=0.1;
}

public void upRight() {
  //println("upper right");
  //extrude
  int i = int(random(1, tmpmodel.getVertexCount()));
  PVector orgv = tmpmodel.getVertex(i);
  PVector tmpv = new PVector();
  tmpv.x = orgv.x * abs(v2.x * .005);
  tmpv.y = orgv.y * abs(v2.y * .005);
  tmpv.z = orgv.z;
  tmpmodel.setVertex(i, tmpv);
}

public void downLeft() {
  //println("lower left");
  rotX += (v2.y * -0.0001);
  rotY += (v2.x * 0.0001);
}

public void downRight() {
  //println("lower right");
  //v2.x > 0 && v2.y > 0
  //println("v2.x" + " " + v2.x + " " + "v2.y" + " " + v2.y);
  if (v2.x > 0 && v2.x < 50 && v2.y > 0 && v2.y < 50) {
    tmpmodel.setTexture(a);
  }
  else if (v2.x > 50 && v2.x > 100 && v2.y > 50 && v2.y > 100) {
    tmpmodel.setTexture(b);
  }
  else if (v2.x > 100 && v2.x > 150 && v2.y > 100 && v2.y > 150) {
    tmpmodel.setTexture(c);
  }
}


  //public void setTexture(PImage a) {
  // texture = a;
  //}

  void transform() {
    rotateY(rotY);
    rotateX(rotX);
  }

  //float k = 0.0;
  //void animation() {
  //
  //  for(int i = 0; i < model.getVertexCount(); i++) {
  //    PVector orgv = model.getVertex(i);
  //    //    PVector tmpv = new PVector();
  //    //    tmpv.x = orgv.x * (abs(sin(k+i*0.04)) * 0.3 + 1.0);
  //    //    tmpv.y = orgv.y * (abs(cos(k+i*0.04)) * 0.3 + 1.0);
  //    //    tmpv.z = orgv.z * (abs(cos(k/5.)) * 0.3 + 1.0);
  //    PVector tmpv = new PVector();
  //    tmpv.x = orgv.x + 320;
  //    tmpv.y = orgv.y + 240;
  //    tmpv.z = orgv.z;
  //    tmpmodel.setVertex(i, tmpv);
  //  }
  //  k+=0.1;
  //}

