public void initControllers() {
  nav=new Nav3D(); 

  controlP5 = new ControlP5(this);
  controlP5.setColorBackground(50);
  controlP5.addButton("Refresh",0,100,100,80,19);
  controlP5.addButton("Hull", 0,100,120,80,19);
  controlP5.addButton("WireFrame", 0,100,140,80,19);
  controlP5.addButton("Grid", 0,100,160,80,19);
  controlP5.addButton("Export", 0,100,180,80,19);
  controlP5.addButton("Spline", 0,100,200,80,19);
  controlP5.addButton("Edit", 0,100,220,80,19);
  controlP5.addButton("Save", 0,100,240,80,19);
  controlP5.addButton("Load", 0,100,260,80,19);
  
  controlP5.addButton("BlueHull", 0,200,120,80,19);
  controlP5.addButton("RedHull",0,200,140,80,19);
  
  controlP5.addButton("ExportBlue",0,200,180,80,19);
  controlP5.addButton("ExportRed",0,200,200,80,19);
}



// pass mouse and key events to our Nav3D instance
void mouseDragged() {
  // ignore mouse event if cursor is over controlP5 GUI elements
  if(controlP5.window(this).isMouseOver()) return;

  nav.mouseDragged();
}

void mouseReleased() {
  nav.mouseReleased();
}

void keyPressed() {
  nav.keyPressed();
}


public void drawGrid() {

  //draw rest of grid 
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      for( int k = 0; k < gridSize; k++) {
        stroke(100);
        strokeWeight(2);  
        point(xpos, ypos, zpos);
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
  stroke(150,0,150);
  line(0,0,0, 100,0,0);
  fill(150,0,150);
  text("X", 260, 0);
  stroke(0,150,0);
  line(0,0,0, 0,-100,0);
  fill(0,150,0);
  text("Y", 0, -260);
  stroke(0,0,150);
  line(0,0,0, 0,0,100);
  fill(0,0, 150);
  text("Z", 0, 0, 260);
  fill(0,0,0);
}

public void Hull(int theValue) { 
  if (doHull == true) {
    doHull = false;
  }
  else if (doHull == false) {
    doHull = true;
  }
}

public void BlueHull(int theValue) { 
  if (doBlueHull == true) {
    doBlueHull = false;
  }
  else if (doBlueHull == false) {
    doBlueHull = true;
  }
}

public void RedHull(int theValue) { 
  if (doRedHull == true) {
    doRedHull = false;
  }
  else if (doRedHull == false) {
    doRedHull = true;
  }
}


public void WireFrame(int theValue) {

  if (doFill == true) {
    //doHull = true;
    doFill = false;
  }
  else if (doFill == false) {
    //doHull = true;
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

  if (mouseOver == true) {
    mouseOver = false;
  }
  else if (mouseOver == false) {
    mouseOver = true;
  }
}


public void Spline(int theValue) {

  if(doSpline == true) {
    doSpline = false;
  }

  else if(doSpline == false) {
    doSpline = true;
  }
}

public void drawSpline() {

  if(points.length > 3) {


    sVectors = new Vec3D[0];

    for(int i = 0; i <points.length; i++) {

      float x = (float)points[i].x;
      float y = (float)points[i].y;
      float z = (float)points[i].z;

      Vec3D tempVect = new Vec3D(x,y,z);
      sVectors = (Vec3D[])append(sVectors, tempVect);
    }

    Spline3D spline = new Spline3D(sVectors);
    java.util.List vertices = spline.computeVertices(8);

    noFill();
    beginShape();
    for(Iterator i=vertices.iterator(); i.hasNext(); ) {
      Vec3D v=(Vec3D)i.next();
      vertex(v.x,v.y,v.z);
    }
    endShape();
  }
}

public void Export(int theValue) {
  redHull();
  blueHull();
  outputSTL();
}

public void ExportBlue(int theValue) {
 
  blueHull();
  blueSTL(); 
}

public void ExportRed(int theValue) {
 
  redHull();
  redSTL(); 
}


public void outputSTL() {

  TriangleMesh mySTL = new TriangleMesh();

  for(int i = 0; i < vectors.length; i+=3) {

    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
    //println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }

  mySTL.addMesh(mesh);
  mySTL.saveAsSTL(selectOutput());
  //mySTL.saveAsSTL(selectOuput());
}

public void blueSTL() {

  TriangleMesh myBlueSTL = new TriangleMesh();

  for(int i = 0; i < blueVectors.length; i+=3) {

    blueMesh.addFace(blueVectors[i], blueVectors[i+1], blueVectors[i+2]);
    //println(blueVectors[i] + " " + blueVectors[i+1] + " " + blueVectors[i+2]);
  }

  myBlueSTL.addMesh(blueMesh);
  myBlueSTL.saveAsSTL(selectOutput());
}

public void redSTL() {

  TriangleMesh myRedSTL = new TriangleMesh();

  for(int i = 0; i < redVectors.length; i+=3) {

    redMesh.addFace(redVectors[i], redVectors[i+1], redVectors[i+2]);
    //println(redVectors[i] + " " + redVectors[i+1] + " " + redVectors[i+2]);
  }

  myRedSTL.addMesh(redMesh);
  myRedSTL.saveAsSTL(selectOutput());
}



public void Save(int theValue) {

  // Create a new file in the sketch directory
  output = createWriter(selectOutput());
  //write the coorditates to the file
  for(int i = 0; i < vectors.length; i++) {
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
