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
  //text("0,0,0", 0,0,0);
}

//public void Export(int theValue) {
//  outputSTL();
//}
//
////function to output STL file
//void outputSTL() {
//  
//  int numPoints = points.length;
//  //check hull
//  if (hull.myCheck(points, numPoints) == true) {
//
//    //compute the convex hull
//    hull.build(points);
//
//    //get an array of the vertices so we can get the faces  
//    Point3d[] vertices = hull.getVertices();
//
//    //start writing the stl file - file should appear in your sketch folder
//    stl=(STL)beginRaw("unlekker.data.STL", selectOutput());  
//
//    //different beginShape() modes may affect the shape produced 
//    beginShape(TRIANGLE_STRIP);  
//    //println ("Faces:");
//    int[][] faceIndices = hull.getFaces();
//    for (int i = 0; i < faceIndices.length; i++) {  
//      for (int k = 0; k < faceIndices[i].length; k++) {
//
//        //get points that correspond to each face
//        Point3d pnt2 = vertices[faceIndices[i][k]];
//        float x = (float)pnt2.x;
//        float y = (float)pnt2.y;
//        float z = (float)pnt2.z;
//        vertex(x,y,z);
//      }
//    }
//
//    endShape(CLOSE);
//    endRaw();
//  }
//}

public void Mode(int theValue) { 
  counter++;
  println(counter);
  showShape();
}

public void showShape() {

  int numPoints = points.length;

  if(hull.myCheck(points, numPoints) == false) {

    //brute force inefficiency
    beginShape(TRIANGLE_STRIP);
    strokeWeight(1);
    fill(0);

    for (int j = 0; j < numPoints; j++) {

      float x = (float)points[j].x;
      float y = (float)points[j].y;
      float z = (float)points[j].z;
      vertex(x,y,z);
    }

    endShape(CLOSE);
  }

  //compute the convex hull
  else if (hull.myCheck(points, numPoints) == true) {  


    if(reDraw == true) {
      //print("redraw = true");
      hull.build(points);
      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = hull.getVertices();
      savedPoints = new Point3d[0];

      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      //noFill(); 
      int[][] faceIndices = hull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
          //println(x + "," + y + "," + z);
          savedPoints = (Point3d[])append(savedPoints, pnt2);
          //savedPoints[k] = new Point3d(pnt2);
          //println(savedPoints[k]);

          //println(x + "," + y + "," + z);
        }
      }
      endShape(CLOSE);
      reDraw = false;
    }

    else if(reDraw == false) {
     // print("redraw = false");
      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      noFill(); 
      for(int i = 0; i < savedPoints.length; i++) {
        
        float x = (float)savedPoints[i].x;
        float y = (float)savedPoints[i].y;
        float z = (float)savedPoints[i].z;
        vertex(x,y,z);
        
      }
      endShape(CLOSE);
    }
  }
}

