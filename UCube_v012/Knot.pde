public void drawKnot() {

  //int offset = 10;
  //int offset = spacing/2;
  //lerpPoints();
  //doCubes();

  strokeWeight(1);
  fill(200);

  for (int i = 0; i < knotVectors.size()-1; i++) {

    Vec3D vec = knotVectors.get(i);     
    float x = (float)vec.x;
    float y = (float)vec.y;
    float z = (float)vec.z;

    Vec3D vec2 = knotVectors.get(i+1);     
    float x2 = (float)vec2.x;
    float y2 = (float)vec2.y;
    float z2 = (float)vec2.z;

    line(x, y, z, x2, y2, z2);
    
  }


  for (int i = 0; i < knotVectors.size()-1; i++) {

    Vec3D vec = knotVectors.get(i);
    float x = (float)vec.x;
    float y = (float)vec.y;
    float z = (float)vec.z;

    Vec3D vec2 = knotVectors.get(i+1);
    float x2 = (float)vec2.x;
    float y2 = (float)vec2.y;
    float z2 = (float)vec2.z;

    knotPoints = new Point3d[0];


    Point3d p1 = new Point3d(x+offset, y+offset, z+offset);
    Point3d p2 = new Point3d(x+offset, y+offset, z-offset);
    Point3d p3 = new Point3d(x+offset, y-offset, z+offset);
    Point3d p4 = new Point3d(x-offset, y+offset, z+offset);

    Point3d p5 = new Point3d(x-offset, y-offset, z+offset);
    Point3d p6 = new Point3d(x-offset, y+offset, z-offset);
    Point3d p7 = new Point3d(x+offset, y-offset, z-offset);
    Point3d p8 = new Point3d(x-offset, y-offset, z-offset);

    Point3d p9 = new Point3d(x2+offset, y2+offset, z2+offset);
    Point3d p10 = new Point3d(x2+offset, y2+offset, z2-offset);
    Point3d p11 = new Point3d(x2+offset, y2-offset, z2+offset);
    Point3d p12 = new Point3d(x2-offset, y2+offset, z2+offset);

    Point3d p13 = new Point3d(x2-offset, y2-offset, z2+offset);
    Point3d p14 = new Point3d(x2-offset, y2+offset, z2-offset);
    Point3d p15 = new Point3d(x2+offset, y2-offset, z2-offset);
    Point3d p16 = new Point3d(x2-offset, y2-offset, z2-offset);


    knotPoints = (Point3d[])append(knotPoints, p1);
    knotPoints = (Point3d[])append(knotPoints, p2);
    knotPoints = (Point3d[])append(knotPoints, p3);
    knotPoints = (Point3d[])append(knotPoints, p4);

    knotPoints = (Point3d[])append(knotPoints, p5);
    knotPoints = (Point3d[])append(knotPoints, p6);
    knotPoints = (Point3d[])append(knotPoints, p7);
    knotPoints = (Point3d[])append(knotPoints, p8);

    knotPoints = (Point3d[])append(knotPoints, p9);
    knotPoints = (Point3d[])append(knotPoints, p10);
    knotPoints = (Point3d[])append(knotPoints, p11);
    knotPoints = (Point3d[])append(knotPoints, p12);

    knotPoints = (Point3d[])append(knotPoints, p13);
    knotPoints = (Point3d[])append(knotPoints, p14);
    knotPoints = (Point3d[])append(knotPoints, p15);
    knotPoints = (Point3d[])append(knotPoints, p16);

    doKnotHull(knotPoints);
  }
}


void doCubes() {
 
 
    for (int i = 0; i < knotVectors.size(); i++) {

    Vec3D vec = knotVectors.get(i);
    float x = (float)vec.x;
    float y = (float)vec.y;
    float z = (float)vec.z;

    knotPoints = new Point3d[0];


    Point3d p1 = new Point3d(x+offset, y+offset, z+offset);
    Point3d p2 = new Point3d(x+offset, y+offset, z-offset);
    Point3d p3 = new Point3d(x+offset, y-offset, z+offset);
    Point3d p4 = new Point3d(x-offset, y+offset, z+offset);

    Point3d p5 = new Point3d(x-offset, y-offset, z+offset);
    Point3d p6 = new Point3d(x-offset, y+offset, z-offset);
    Point3d p7 = new Point3d(x+offset, y-offset, z-offset);
    Point3d p8 = new Point3d(x-offset, y-offset, z-offset);
    
    knotPoints = (Point3d[])append(knotPoints, p1);
    knotPoints = (Point3d[])append(knotPoints, p2);
    knotPoints = (Point3d[])append(knotPoints, p3);
    knotPoints = (Point3d[])append(knotPoints, p4);

    knotPoints = (Point3d[])append(knotPoints, p5);
    knotPoints = (Point3d[])append(knotPoints, p6);
    knotPoints = (Point3d[])append(knotPoints, p7);
    knotPoints = (Point3d[])append(knotPoints, p8);

    doKnotHull(knotPoints);
    
    }
  
}


void lerpPoints() {

  int kv = knotVectors.size();
  
  if (kv > 1) {
    Vec3D vec = knotVectors.get(kv-2);
    Vec3D vec2 = knotVectors.get(kv-1);
    
    //float d = vec.distanceTo(vec2);
    Vec3D s = vec.add(vec2);
    //s = s.invert();
    println("added: " + s);
    
    float x = (float)s.x/2;
    float y = (float)s.y/2;
    float z = (float)s.z/2;
    
    Vec3D l = new Vec3D(x,y,z);
    
    println("lerp: " + l);
    knotVectors.add(kv-1, l);
    
    
  }
}



//can close knot by taking last point and first point in array and adding that hull to the shape?
public void closeKnot() {

  int i = knotVectors.size();
  println(i);

  Vec3D vec = knotVectors.get(0);
  float x = (float)vec.x;
  float y = (float)vec.y;
  float z = (float)vec.z;

  Vec3D vec2 = knotVectors.get(i-1);
  float x2 = (float)vec2.x;
  float y2 = (float)vec2.y;
  float z2 = (float)vec2.z;

  knotPoints = new Point3d[0];


  Point3d p1 = new Point3d(x+offset, y+offset, z+offset);
  Point3d p2 = new Point3d(x+offset, y+offset, z-offset);
  Point3d p3 = new Point3d(x+offset, y-offset, z+offset);
  Point3d p4 = new Point3d(x-offset, y+offset, z+offset);

  Point3d p5 = new Point3d(x-offset, y-offset, z+offset);
  Point3d p6 = new Point3d(x-offset, y+offset, z-offset);
  Point3d p7 = new Point3d(x+offset, y-offset, z-offset);
  Point3d p8 = new Point3d(x-offset, y-offset, z-offset);

  Point3d p9 = new Point3d(x2+offset, y2+offset, z2+offset);
  Point3d p10 = new Point3d(x2+offset, y2+offset, z2-offset);
  Point3d p11 = new Point3d(x2+offset, y2-offset, z2+offset);
  Point3d p12 = new Point3d(x2-offset, y2+offset, z2+offset);

  Point3d p13 = new Point3d(x2-offset, y2-offset, z2+offset);
  Point3d p14 = new Point3d(x2-offset, y2+offset, z2-offset);
  Point3d p15 = new Point3d(x2+offset, y2-offset, z2-offset);
  Point3d p16 = new Point3d(x2-offset, y2-offset, z2-offset);


  knotPoints = (Point3d[])append(knotPoints, p1);
  knotPoints = (Point3d[])append(knotPoints, p2);
  knotPoints = (Point3d[])append(knotPoints, p3);
  knotPoints = (Point3d[])append(knotPoints, p4);

  knotPoints = (Point3d[])append(knotPoints, p5);
  knotPoints = (Point3d[])append(knotPoints, p6);
  knotPoints = (Point3d[])append(knotPoints, p7);
  knotPoints = (Point3d[])append(knotPoints, p8);

  knotPoints = (Point3d[])append(knotPoints, p9);
  knotPoints = (Point3d[])append(knotPoints, p10);
  knotPoints = (Point3d[])append(knotPoints, p11);
  knotPoints = (Point3d[])append(knotPoints, p12);

  knotPoints = (Point3d[])append(knotPoints, p13);
  knotPoints = (Point3d[])append(knotPoints, p14);
  knotPoints = (Point3d[])append(knotPoints, p15);
  knotPoints = (Point3d[])append(knotPoints, p16);

  doKnotHull(knotPoints);
}

public void doKnotHull(Point3d[] knotPoints) {


  int numPoints = knotPoints.length;
  //kVectors = new Vec3D[0];

  if (knotHull.myCheck(knotPoints, numPoints) == false) {
  }
  else if (knotHull.myCheck(knotPoints, numPoints) == true) {

    //if (reDrawKnot == true) {


    knotHull.build(knotPoints);
    knotHull.triangulate();
    //get an array of the vertices so we can get the faces  
    Point3d[] vertices = knotHull.getVertices();
    //kSavedPoints = new Point3d[0];
    //kVectors = new Vec3D[0];

    //      beginShape(TRIANGLE_STRIP);
    //      strokeWeight(1);
    fill(200);
    if (doFill == false) {
      noFill();
    }  
    int[][] faceIndices = knotHull.getFaces();
    for (int i = 0; i < faceIndices.length; i++) { 

      for (int k = 0; k < faceIndices[i].length; k++) {

        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        //vertex(x, y, z);
        Vec3D tempVect = new Vec3D(x, y, z);
        //println(x + "," + y + "," + z + " " + k);
        kSavedPoints = (Point3d[])append(kSavedPoints, pnt2);
        kVectors = (Vec3D[])append(kVectors, tempVect);
        //kSavedPoints[k] = new Point3d(pnt2);
        //println(savedPoints[k]);

        //println(x + "," + y + "," + z);
      }
    }
    //endShape(CLOSE);
    reDrawKnot = false;
    println("false");
  }

  //    else if (reDrawKnot == false) {
  //      //print(reDraw);
  //      //      beginShape(TRIANGLE_STRIP);
  //      //      strokeWeight(1);
  //      //      fill(200);
  //      //      if (doFill == false) {
  //      //        noFill();
  //      //      } 
  //      //      for (int i = 0; i < kSavedPoints.length; i++) {
  //      //
  //      //        float x = (float)kSavedPoints[i].x;
  //      //        float y = (float)kSavedPoints[i].y;
  //      //        float z = (float)kSavedPoints[i].z;
  //      //        vertex(x, y, z);
  //      //      }
  //      //      endShape(CLOSE);
  //
  //
  //      beginShape(TRIANGLES);
  //
  //      for (int i = 0; i < kVectors.length; i+=3) {
  //
  //        //scale(.05);
  //        //knotMesh.addFace(kVectors[i], kVectors[i+1], kVectors[i+2]);
  //        
  //
  //        vertex(kVectors[i]);
  //        vertex(kVectors[i+1]);
  //        vertex(kVectors[i+2]);
  //
  //        // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  //      }
  //
  //      endShape();
  //
  //      
  //    }
  //  }
}

void vertex(Vec3D v) {
  vertex(v.x, v.y, v.z);
}


public void clearKnot() {

  knotVectors.clear();
  kVectors = null;
  kVectors = new Vec3D[0];

  knotPoints = null;
  knotPoints = new Point3d[0];
  model.reset();
  model2.reset();
  knotMesh.clear();
}


//public void drawModel() {
//
//  float x, y, z;
//  float x2, y2, z2;
//
//  Vec3D t = knotVectors.get(0);
//
//  model.translate((float)t.x, (float)t.y, (float)t.z); 
//
//  for (int i = 0; i < knotVectors.size()-1; i++) {
//
//    Vec3D vec = knotVectors.get(i);
//    x = (float)vec.x;
//    y = (float)vec.y;
//    z = (float)vec.z;
//
//    Vec3D vec2 = knotVectors.get(i+1);
//    x2 = (float)vec2.x;
//    y2 = (float)vec2.y;
//    z2 = (float)vec2.z;  
//
//    if (vec.distanceTo(vec2) > spacing) {
//
//      float d = vec.distanceTo(vec2);
//      float lerps = d / spacing;
//      println(lerps);
//
//      for (int j = 0; j < lerps; j++) {
//        model2.add(Primitive.box(36, 36, 36));
//        model2.translate(((x-x2)/lerps)*-1, ((y-y2)/lerps)*-1, ((z-z2)/lerps)*-1);
//        //println("translation: " + (x-x2) + " " + (y-y2) + " " + (z-z2));
//      }
//    } 
//    else { 
//      model2.add(Primitive.box(36, 36, 36));
//      model2.translate((x-x2)*-1, (y-y2)*-1, (z-z2)*-1);
//    }
//    //println("translation: " + (x-x2) + " " + (y-y2) + " " + (z-z2));
//  }
//
//
//  model2.add(Primitive.box(36, 36, 36));
//  //model.draw(this);
//}

