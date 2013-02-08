void initControllers() {
  nav=new Nav3D(); 
  //  nav.rotX=PI/6;
  //  nav.rotY=PI/6;

  controlP5 = new ControlP5(this);
  controlP5.setColorBackground(50);
  controlP5.addButton("Hull", 0, 100, 100, 80, 19);
  controlP5.addButton("WireFrame", 0, 100, 120, 80, 19);
  controlP5.addButton("Grid", 0, 100, 140, 80, 19);
  controlP5.addButton("Export", 0, 100, 160, 80, 19);
  controlP5.addButton("Spline", 0, 100, 180, 80, 19);
  controlP5.addButton("Edit", 0, 100, 200, 80, 19);
  controlP5.addButton("Save", 0, 100, 220, 80, 19);
  controlP5.addButton("Load", 0, 100, 240, 80, 19);
}

// pass mouse and key events to our Nav3D instance
void mouseDragged() {
  // ignore mouse event if cursor is over controlP5 GUI elements
  if (controlP5.window(this).isMouseOver()) return;

  nav.mouseDragged();
}

void mouseReleased() {
  nav.mouseReleased();
}

void keyPressed() {
  nav.keyPressed();
}




void drawGrid() {

  //draw rest of grid 
  //(spacing * (gridSize -1) * -1) /2 = center around 0 
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      for ( int k = 0; k < gridSize; k++) {
        stroke(100);
        strokeWeight(2);  
        point(xpos, ypos, zpos);
        //println(xpos + "," + ypos + "," + zpos);
        xpos += spacing;
      }
      xpos = 0;
      ypos -= spacing;
    }
    xpos = 0;
    ypos = 0;
    zpos += spacing;
  }
}

public void drawAxes() {

  strokeWeight(1);
  textSize(32);
  stroke(150, 0, 150);
  line(0, 0, 0, 100, 0, 0);
  fill(150, 0, 150);
  text("X", 220, 0);
  stroke(0, 150, 0);
  line(0, 0, 0, 0, -100, 0);
  fill(0, 150, 0);
  text("Y", 0, -220);
  stroke(0, 0, 150);
  line(0, 0, 0, 0, 0, 100);
  fill(0, 0, 150);
  text("Z", 0, 0, 220);
  fill(0, 0, 0);
}

public void Hull(int theValue) { 
  if (doHull == true) {
    doHull = false;
  }
  else if (doHull == false) {
    doHull = true;
  }
}

public void WireFrame(int theValue) {

  if (doFill == true) {
    doHull = true;
    doFill = false;
  }
  else if (doFill == false) {
    doHull = true;
    doFill = true;
  }
}

public void Grid(int theValue) {

  if (doGrid == true) {
    doGrid = false;
  }
  else if (doGrid == false) {
    doGrid = true;
  }
}

public void Edit(int theValue) {

//    if (mouseOver == true) {
//      mouseOver = false;
//  //    //myPort = new Serial(this, Serial.list()[0], 19200);
//    }
//    else if (mouseOver == false) {
//      mouseOver = true;
//    }

  if (readSerial == true) {
    readSerial = false;
    mouseOver = true;
  }
  else if (readSerial == false) {
    readSerial = true;
    mouseOver = false;
  }
}

public void Spline(int theValue) {

  if (doSpline == true) {
    doSpline = false;
  }

  else if (doSpline == false) {
    doSpline = true;
  }

  print(doSpline);
}

public void drawSpline() {

  if (points.length > 2) {


    sVectors = new Vec3D[0];

    for (int i = 0; i <points.length; i++) {

      float x = (float)points[i].x;
      float y = (float)points[i].y;
      float z = (float)points[i].z;

      Vec3D tempVect = new Vec3D(x, y, z);
      sVectors = (Vec3D[])append(sVectors, tempVect);
    }

    Spline3D spline = new Spline3D(sVectors);
    java.util.List vertices = spline.computeVertices(8);

    noFill();
    beginShape();
    for (Iterator i=vertices.iterator(); i.hasNext(); ) {
      Vec3D v=(Vec3D)i.next();
      vertex(v.x, v.y, v.z);
    }
    endShape();
  }
}

public void Export(int theValue) {
  drawHull();
  outputSTL();
}


void outputSTL() {

  TriangleMesh mySTL = new TriangleMesh();

  for (int i = 0; i < vectors.length; i+=3) {

    scale(.1);
    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
    // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }

  mySTL.addMesh(mesh);
 // mySTL.saveAsSTL(selectOutput());
}

public void Save(int theValue) {

  // Create a new file in the sketch directory
 // output = createWriter(selectOutput());
  //write the coorditates to the file
  for (int i = 0; i < vectors.length; i++) {
    output.print(vectors[i].x/spacing + "," + vectors[i].y/spacing *-1 + "," + vectors[i].z/spacing + ";"  );
  }
  output.flush();
  output.close();
}

public void Load(int theValue) {

  //read in a text file
  reader = createReader(selectInput());

  try {
    inString = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

