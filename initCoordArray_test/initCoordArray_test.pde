


public void setup() {
  initCoordArray();
}


public void draw() {
}


public void initCoordArray() {

  for (int x = 6; x > -1; x--) { //flip this to be like y?

    for (int z = 0; z < 7; z++) {

      for (int y = 6; y > -1; y--) {

//        Vec3D tempVect = new Vec3D(x * spacing, y * -spacing, z * spacing); 
//        Point3d tempPoint = new Point3d(x * spacing, y * -spacing, z * spacing);
//        masterVectArray = (Vec3D[])append(masterVectArray, tempVect);
//        masterPointArray = (Point3d[])append(masterPointArray, tempPoint);
        println("x: " + x + "  " + "y: " + y + "  " + "z: " + z);
        //println("points: " + masterPointArray.length);
      }
    }
  }

  //println(vectors.length);
}

