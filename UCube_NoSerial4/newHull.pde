void drawHull() {

  int numPoints = points.length; 
  //check that our hull is valid

  if(hull.myCheck(points, numPoints) == false) {

    //brute force inefficiency
    beginShape(TRIANGLE_STRIP);
    strokeWeight(1);
    fill(200);

    for (int j = 0; j < numPoints; j++) {

      float x = (float)points[j].x;
      float y = (float)points[j].y;
      float z = (float)points[j].z;
      vertex(x,y,z);
    }

    endShape(CLOSE);
  }

  else if (hull.myCheck(points, numPoints) == true) {  

    if(reDraw == true) {
      println(reDraw);
      hull.build(points);
      hull.triangulate();
      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = hull.getVertices();
      savedPoints = new Point3d[0];
      vectors = new Vec3D[0];

      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(200);
      if (doFill == false) {
        noFill();
      } 
      int[][] faceIndices = hull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
          Vec3D tempVect = new Vec3D(x,y,z);
          savedPoints = (Point3d[])append(savedPoints, pnt2);
          vectors = (Vec3D[])append(vectors, tempVect);
        }
      }
      endShape(CLOSE);
      reDraw = false;
    }

    else if(reDraw == false) {
      println(reDraw);
      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(200);
      if (doFill == false) {
        noFill();
      } 
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

