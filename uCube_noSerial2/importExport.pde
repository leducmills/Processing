public void Import (int theValue) {
  importSTL();
}

public void importSTL() {

  String loadPath = selectInput();  // Opens file chooser
  if (loadPath == null) {
    // If a file was not selected
    println("No file was selected...");
  } 
  else {
    inString = null;
    // If a file was selected, print path to file
    println(loadPath);
    stl = new STL(this, loadPath);
    poly = stl.getPolyData();
    int faces = poly.num;
    if (poly != null) {
      //poly.normalize(150);
      //poly.calcBounds();
      //poly.center();

      for( int i = 0; i < faces; i++) {
        poly.f[i].translate(width/2,height/2,650);
      }
    }
  }
}


public void drawImport() {

  beginShape(TRIANGLE_STRIP);
  stroke(255,0,0);
  strokeWeight(1);
  int offset = 0;
  for (int i = 0; i < poly.f.length; i++) {

    //println(poly.f[i]);
    vertex(poly.f[i].v[3] + offset, poly.f[i].v[4] + offset, poly.f[i].v[5] + offset); 
    vertex(poly.f[i].v[6] + offset, poly.f[i].v[7] + offset, poly.f[i].v[8] + offset);
    vertex(poly.f[i].v[9] + offset, poly.f[i].v[10] + offset, poly.f[i].v[11] + offset);
  }
  endShape(CLOSE);
}

public void Export(int theValue) {
  outputSTL();
}

void outputSTL() {
  //function to output STL file
  //make sure we have at least 4 points or an imported stl
  //(can't have a 3d shape with less)
  int numPoints = points.length;
  if(poly != null) { //we have an import

    stl=(STL)beginRaw("unlekker.data.STL", selectOutput());
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < poly.f.length; i++) {

      //println(poly.f[i]);
      vertex(poly.f[i].v[3], poly.f[i].v[4], poly.f[i].v[5]); 
      vertex(poly.f[i].v[6], poly.f[i].v[7], poly.f[i].v[8]);
      vertex(poly.f[i].v[9], poly.f[i].v[10], poly.f[i].v[11]);
    }
    endShape(CLOSE);
    endRaw();
  }


  else if(hull.myCheck(points, numPoints) == true) {

    //compute the convex hull
    hull.build(points);
    hull.triangulate();

    //get an array of the vertices so we can get the faces  
    Point3d[] vertices = hull.getVertices();

    //start writing the stl file
    stl=(STL)beginRaw("unlekker.data.STL", selectOutput());
    //different beginShape() modes may affect the shape produced
    //translate(width/2,height/2,-width/2);
    fill(255);
    int[][] faceIndices = hull.getFaces();
    int numfaces = hull.getNumFaces();
    println("numfaces:" + numfaces);
    beginShape(TRIANGLE_STRIP);   
        for (int i = 0; i < faceIndices.length; i++) {  
          for (int k = 0; k < faceIndices[i].length; k++) {
            print(faceIndices[i][k] + " ");
            //get points that correspond to each face
            Point3d pnt2 = vertices[faceIndices[i][k]];
            float x = (float)pnt2.x;
            float y = (float)pnt2.y;
            float z = (float)pnt2.z;
            vertex(x,y,z);
            //println(x + "," + y + "," + z);
          }
        }

    endShape();
    endRaw();
  }
}


//   System.out.println ("Vertices:");
//   Point3d[] vertices = hull.getVertices();
//   for (int i = 0; i < vertices.length; i++)
//    { Point3d pnt = vertices[i];
//      System.out.println (pnt.x + " " + pnt.y + " " + pnt.z);
//    }
//
//   System.out.println ("Faces:");
//   int[][] faceIndices = hull.getFaces();
//   for (int i = 0; i < faceIndices.length; i++)
//    { for (int k = 0; k < faceIndices[i].length; k++)
//       { System.out.print (faceIndices[i][k] + " ");
//       }
//      System.out.println ("");
//    }
