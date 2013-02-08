public void controlEvent(ControlEvent theEvent) {
  println(theEvent.controller().name());
}

void mouseDragged() {
  float x1 = mouseX-pmouseX;
  float y1 = mouseY-pmouseY;
  rotX = (mouseY * -0.01);
  rotY = (mouseX * 0.01);
}


void translations() {  
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
}

void drawGrid() {

  //draw rest of grid 
  //(spacing * (gridSize -1) * -1) /2 = center around 0 
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      for( int k = 0; k < gridSize; k++) {
        stroke(100);
        strokeWeight(2);  
        point(xpos, ypos, zpos);
        //println(xpos + "," + ypos + "," + zpos);
        xpos += spacing;
      }
      xpos = 0;
      ypos += spacing;
    }
    xpos = 0;
    ypos = 0;
    zpos += spacing;
  }
}

void drawAxes() {

  stroke(255,0,255);
  line(0,0,0, 100,0,0);
  fill(255,0,255);
  text("X", 200, 0);
  stroke(0,255,0);
  line(0,0,0, 0,-100,0);
  fill(0,255,0);
  text("Y", 0, -200);
  stroke(0,0,255);
  line(0,0,0, 0,0,100);
  fill(0,0, 255);
  text("Z", 0, 0, 200);
  fill(0,0,0);
}

public void Mode(int theValue) { 
  counter++;
  println(counter);
  drawHull();
}


public void Export(int theValue) {
  outputSTL();
}


void outputSTL() {

  TriangleMesh mySTL = new TriangleMesh();

  for(int i = 0; i < vectors.length; i+=3) {

    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
   // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }

  mySTL.addMesh(mesh);
  mySTL.saveAsSTL(selectOutput());
}
