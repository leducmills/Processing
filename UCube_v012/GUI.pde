//Initialize buttons and NAV3D class
void initControllers() {
  nav=new Nav3D(); 

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
  controlP5.addButton("Knot", 0, 100, 260, 80, 19);
  controlP5.addButton("ExportKnot", 0, 100, 280, 80, 19);
  controlP5.addButton("ClearKnot", 0, 100, 300, 80, 19);
  controlP5.addButton("CloseKnot", 0, 100, 320, 80, 19);
  
 
  Slider s = controlP5.addSlider("offset",
    5,35,
    offset,
    100,340,
    80,19);
    
    controlP5.Label label = s.captionLabel();
    label.style().marginLeft = -140;
    s.setColorLabel(50);
    s.setLabel("knot width");
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



//draw the little grey grid
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

//draw the axes
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


//toggle convex hull
public void Hull(int theValue) { 
  if (doHull == true) {
    doHull = false;
  }
  else if (doHull == false) {
    doHull = true;
  }
}

//toggle wireframe
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

//toggle grid
public void Grid(int theValue) {

  if (doGrid == true) {
    doGrid = false;
  }
  else if (doGrid == false) {
    doGrid = true;
  }
}

//toggle knot
public void Knot(int theValue) {

  if (doKnot == true) {
    doKnot = false;
  }
  else if (doKnot == false) {
    doKnot = true;
    drawKnot();
  }
  


}

//clear the knot arrays
public void ClearKnot(int theValue) {
  clearKnot();
}

public void CloseKnot(int theValue) {
  closeKnot();
}


//enter edit mode
public void Edit(int theValue) {

  if (readSerial == true) {
    readSerial = false;
    mouseOver = true;
  }
  else if (readSerial == false) {
    readSerial = true;
    mouseOver = false;
  }
}

//toggle spline
public void Spline(int theValue) {

  if (doSpline == true) {
    doSpline = false;
  }

  else if (doSpline == false) {
    doSpline = true;
  }

  print(doSpline);
}

//draw a spline through the points
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

    Spline3D spline = new Spline3D(knotVectors);
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

//export stl of convex hull
public void Export(int theValue) {
  drawHull();
  outputSTL();
}

//export stl of knot
public void ExportKnot(int theValue) {
  outputKnot();
}

//stl writer for convex hull
void outputSTL() {

  TriangleMesh mySTL = new TriangleMesh();

  for (int i = 0; i < vectors.length; i+=3) {

    //scale(.05);
    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
    // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }

  mySTL.addMesh(mesh);
  mySTL.saveAsSTL(selectOutput());
}

//stl writer for knot
void outputKnot() {
  
   TriangleMesh mySTL = new TriangleMesh();

  for (int i = 0; i < kVectors.length; i+=3) {

    //scale(.05);
    knotMesh.addFace(kVectors[i], kVectors[i+1], kVectors[i+2]);
    println(kVectors[i] + " " + kVectors[i+1] + " " + kVectors[i+2]);
  }
  
  //knotMesh.faceOutwards();
  //knotMesh.computeCentroid();
  //knotMesh.computeFaceNormals();
  //knotMesh.computeVertexNormals();
  knotMesh.flipVertexOrder();
  
  mySTL.addMesh(knotMesh);
  
  
  mySTL.saveAsSTL(selectOutput());
 
  
}


//void outputKnot() {
//
//  for (int i = 0; i < knotVectors.size()-1; i++) {
//
//    Vec3D vec = knotVectors.get(i);
//    float x = (float)vec.x;
//    float y = (float)vec.y;
//    float z = (float)vec.z;
//
//    Vec3D vec2 = knotVectors.get(i+1);
//    float x2 = (float)vec2.x;
//    float y2 = (float)vec2.y;
//    float z2 = (float)vec2.z;  
//
//    //println("distance: " + vec.distanceTo(vec2));
//
//    //    float d = vec.distanceTo(vec2);
//    //    float lerps = d / spacing;
//    //    println(lerps);
//
//    if (vec.distanceTo(vec2) > spacing) {
//
//      float d = vec.distanceTo(vec2);
//      float lerps = d / spacing;
//      println(lerps);
//
//      for (int j = 0; j < lerps; j++) {
//        model.add(Primitive.box(36, 36, 36));
//        model.translate((x-x2)/lerps, (y-y2)/lerps, (z-z2)/lerps);
//        println("translation: " + (x-x2) + " " + (y-y2) + " " + (z-z2));
//      }
//    } else { 
//      model.add(Primitive.box(36, 36, 36));
//      model.translate(x-x2, y-y2, z-z2);
//    }
//    //println("translation: " + (x-x2) + " " + (y-y2) + " " + (z-z2));
//  }
//
//  model.add(Primitive.box(36, 36, 36));
//  model.writeSTL(this, selectOutput());
//
//
//  //  TriangleMesh mySTL = new TriangleMesh();
//  //
//  //  TriangleMesh v2 = new TriangleMesh();
//  //
//  //  for (int i = 0; i < kVectors.length; i+=3) {
//  //
//  //    //scale(.05);
//  //    knotMesh.addFace(kVectors[i], kVectors[i+1], kVectors[i+2]);
//  //    // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
//  //  }
//  //
//  //  Collection<Vertex> verts = new ArrayList<Vertex>();
//  //  verts = knotMesh.getVertices();
//  ////  println(verts.size());
//  ////
//  ////  Collection<Face> faces = new ArrayList<Face>();
//  ////  faces = knotMesh.getFaces();
//  ////  println(faces.size());
//  ////
//  ////  //  Vec3D[] cleanVects = new Vec3D[0]; 
//  ////  Iterator<Face> iterator = faces.iterator();
//  ////  while (iterator.hasNext()) {
//  ////    Face f = iterator.next();
//  ////    Triangle3D tri3D = f.toTriangle();
//  ////
//  ////    Iterator<Vertex> iterator2 = verts.iterator();
//  ////    while (iterator2.hasNext ()) {
//  ////      Vertex v = iterator2.next();
//  ////      Vec3D v3d = new Vec3D(v.x, v.y, v.z);
//  ////
//  ////      if (tri3D.containsPoint(v3d)) {
//  ////        iterator.remove();
//  ////        println("removed " + f);
//  ////      }
//  ////      
//  ////    }
//  ////    
//  ////  }
//  ////  
//  ////  println(faces.size());
//  //
//  //
//  ////    Iterator<Vertex> iterator = verts.iterator();
//  ////    while(iterator.hasNext()) {
//  ////     Vertex v = iterator.next();
//  ////     Vec3D v3d = new Vec3D(v.x, v.y, v.z);
//  ////     point(v.x, v.y, v.z);
//  ////     cleanVects = (Vec3D[])append(cleanVects, v3d);
//  ////     println(v); 
//  ////    }
//  ////    
//  ////    for(int j = 0; j < cleanVects.length-2; j++) {
//  ////      v2.addFace(cleanVects[j], cleanVects[j+1], cleanVects[j+2]);
//  ////    }
//  //    
//  ////    println("verts size: " + verts.size());
//  ////    println("num verts: " + knotMesh.getNumVertices());
//  //    knotMesh.faceOutwards();
//  //    //v2.faceOutwards();
//  //     
//  //    //mySTL.scale(.5);
//  //    mySTL.addMesh(knotMesh);
//  //    //mySTL.addMesh(v2);
//  //    mySTL.saveAsSTL(selectOutput());
//}

//save a text file of active points
public void Save(int theValue) {

  // Create a new file in the sketch directory
  output = createWriter(selectOutput());
  //write the coorditates to the file
  for (int i = 0; i < vectors.length; i++) {
    output.print(vectors[i].x/spacing + "," + vectors[i].y/spacing *-1 + "," + vectors[i].z/spacing + ";"  );
  }
  output.flush();
  output.close();
}

//load in a text file of active points
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

