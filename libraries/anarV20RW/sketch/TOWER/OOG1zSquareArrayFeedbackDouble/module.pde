


Obj createModule(Transform t, Param pZ, Param pX, Param pY) {
  int edge = 10;
  int h = 1;
  //Create the base points (here a square)

  //Create a new Face
  Face mySquare = new Face();
  mySquare.add(Anar.Pt(-edge/2,0, -edge/2));
  mySquare.add(Anar.Pt(edge/2,0,-edge/2));
  mySquare.add(Anar.Pt(edge/2,0, edge/2));
  mySquare.add(Anar.Pt(-edge/2,0,edge/2));

  Obj cube = new Extrude(mySquare, Anar.Pt(0,h,0));

  Transform tt = new Transform();
  tt.rotateZ(pZ);
  tt.rotateX(pX);
  tt.rotateY(pY);
  tt.add(t);
  cube.apply(tt);

  // store face of the cube to compute distance to "sun"
  // see update tab
  faces.add(cube.face(5));

  return cube;  
}  
