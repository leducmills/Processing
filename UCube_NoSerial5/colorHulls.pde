void redHull() {

  int numPoints = redPoints.length; 
  //println("redhull: " + redPoints.length);
  //check that our hull is valid

  if(redHull.myCheck(redPoints, numPoints) == false) {

    //brute force inefficiency
    beginShape(TRIANGLE_STRIP);
    strokeWeight(1);
    fill(255,0,0);
    stroke(255,0,0);

    for (int j = 0; j < numPoints; j++) {

      float x = (float)redPoints[j].x;
      float y = (float)redPoints[j].y;
      float z = (float)redPoints[j].z;
      vertex(x,y,z);
    }

    endShape(CLOSE);
  }

  else if (redHull.myCheck(redPoints, numPoints) == true) {  

    if(reDraw == true) {
      //println(reDraw);
      redHull.build(redPoints);
      redHull.triangulate();
      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = redHull.getVertices();
      savedRedPoints = new Point3d[0];
      //vectors = new Vec3D[0];
      redVectors = new Vec3D[0];

      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(255,0,0);
      stroke(255,0,0);
      if (doFill == false) {
        noFill();
      } 
      int[][] faceIndices = redHull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
          Vec3D tempVect = new Vec3D(x,y,z);
          savedRedPoints = (Point3d[])append(savedRedPoints, pnt2);
          redVectors = (Vec3D[])append(redVectors, tempVect);
          //vectors = (Vec3D[])append(vectors, tempVect);
        }
      }
      endShape(CLOSE);
      //reDraw = false;
    }

    else if(reDraw == false) {
      //println(reDraw);
      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(255,0,0);
      stroke(255,0,0);
      if (doFill == false) {
        noFill();
      } 
      for(int i = 0; i < savedRedPoints.length; i++) {

        float x = (float)savedRedPoints[i].x;
        float y = (float)savedRedPoints[i].y;
        float z = (float)savedRedPoints[i].z;
        vertex(x,y,z);
      }
      endShape(CLOSE);
    }
  }
}



void blueHull() {

  int numPoints = bluePoints.length;
 //println("bluehull: " + bluePoints.length); 
  //check that our hull is valid

  if(blueHull.myCheck(bluePoints, numPoints) == false) {

    //brute force inefficiency
    beginShape(TRIANGLE_STRIP);
    strokeWeight(1);
    fill(0,0,255);
    stroke(0,0,255);

    for (int j = 0; j < numPoints; j++) {

      float x = (float)bluePoints[j].x;
      float y = (float)bluePoints[j].y;
      float z = (float)bluePoints[j].z;
      vertex(x,y,z);
    }

    endShape(CLOSE);
  }

  else if (blueHull.myCheck(bluePoints, numPoints) == true) {  

    if(reDraw == true) {
      //println(reDraw);
      blueHull.build(bluePoints);
      blueHull.triangulate();
      //get an array of the vertices so we can get the faces  
      Point3d[] vertices = blueHull.getVertices();
      savedBluePoints = new Point3d[0];
      //vectors = new Vec3D[0];
      blueVectors = new Vec3D[0];

      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(0,0,255);
      stroke(0,0,255);
      if (doFill == false) {
        noFill();
      } 
      int[][] faceIndices = blueHull.getFaces();
      for (int i = 0; i < faceIndices.length; i++) {  
        for (int k = 0; k < faceIndices[i].length; k++) {

          //get points that correspond to each face
          Point3d pnt2 = vertices[faceIndices[i][k]];
          float x = (float)pnt2.x;
          float y = (float)pnt2.y;
          float z = (float)pnt2.z;
          vertex(x,y,z);
          Vec3D tempVect = new Vec3D(x,y,z);
          savedPoints = (Point3d[])append(savedBluePoints, pnt2);
          //vectors = (Vec3D[])append(vectors, tempVect);
          blueVectors = (Vec3D[])append(blueVectors, tempVect);
        }
      }
      endShape(CLOSE);
      //reDraw = false;
    }

    else if(reDraw == false) {
      //println(reDraw);
      beginShape(TRIANGLE_STRIP);
      strokeWeight(1);
      fill(0,0,255);
      stroke(0,0,255);
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



