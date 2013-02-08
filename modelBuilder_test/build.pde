void buildModel() {

  int offset = 10;
  
  float x = 0;
  float y = 0;
  float z = 0;
  UVec3 vec = new UVec3(x,y,z);
  
  float x2 = 0;
  float y2 = -100;
  float z2 = 0;
  UVec3 vec2 = new UVec3(x2, y2, z2);
  
  
//  
//  float x3 = 50;
//  float y3 = 50;
//  float z3 = 10;
  
  
  //box around point1
  UVec3 v0a = new UVec3(x+offset, y+offset, z+offset);
  UVec3 v1a = new UVec3(x-offset, y+offset, z+offset);
  UVec3 v2a = new UVec3(x-offset, y-offset, z+offset);
  UVec3 v3a = new UVec3(x+offset, y-offset, z+offset);
  UVec3 v4a = new UVec3(x+offset, y-offset, z-offset);
  UVec3 v5a = new UVec3(x+offset, y+offset, z-offset);
  UVec3 v6a = new UVec3(x-offset, y+offset, z-offset);
  UVec3 v7a = new UVec3(x-offset, y-offset, z-offset);
  
  //box around point2
  UVec3 v0b = new UVec3(x2+offset, y2+offset, z2+offset);
  UVec3 v1b = new UVec3(x2-offset, y2+offset, z2+offset);
  UVec3 v2b = new UVec3(x2-offset, y2-offset, z2+offset);
  UVec3 v3b = new UVec3(x2+offset, y2-offset, z2+offset);
  UVec3 v4b = new UVec3(x2+offset, y2-offset, z2-offset);
  UVec3 v5b = new UVec3(x2+offset, y2+offset, z2-offset);
  UVec3 v6b = new UVec3(x2-offset, y2+offset, z2-offset);
  UVec3 v7b = new UVec3(x2-offset, y2-offset, z2-offset);
  
  //cube1
  model.beginShape(TRIANGLE_FAN);
  
  //front
  model.addFace(v0a, v1a, v2a);
  model.addFace(v2a, v3a, v0a);
  
  //right
  model.addFace(v0a, v3a, v4a);
  model.addFace(v4a, v5a, v0a);
  
  //top
  model.addFace(v0a, v5a, v6a);
  model.addFace(v6a, v1a, v0a);
  
  //left
  model.addFace(v6a, v1a, v2a);
  model.addFace(v2a ,v7a, v6a);
  
  //bottom
  //model.addFace(v7a, v2a, v3a);
  //model.addFace(v3a, v4a, v7a);
  
  //back
  model.addFace(v5a, v6a, v7a);
  model.addFace(v7a, v4a, v5a);
  
  //model.endShape();
  
  //lerped rectangle between p1 and p2
//  float d = vec.distanceTo(vec2);
//  float lerps = d / offset;
//  
//  for(int i = 0; i < lerps; i++) {
//    
//  }

  //exact points for lerped rect
  //front
  model.addFace(v2a, v3a, v0b);
  model.addFace(v0b, v1b, v2a);
  
  //right
  model.addFace(v3a, v4a, v5b);
  model.addFace(v5b, v0b, v3a);
  
//  //top
//  model.addFace(v0a, v5a, v6a);
//  model.addFace(v6a, v1a, v0a);
  
  //left
  model.addFace(v2a, v7a, v6b);
  model.addFace(v6b ,v1b, v2a);
  
//  //bottom
//  model.addFace(v7a, v2a, v3a);
//  model.addFace(v3a, v4a, v7a);
  
  //back
  model.addFace(v7a, v4a, v5b);
  model.addFace(v5b, v6b, v7a);
  
  
  //cube2
  //model.beginShape(TRIANGLE_FAN);
  
  //front
  model.addFace(v0b, v1b, v2b);
  model.addFace(v2b, v3b, v0b);
  
  //right
  model.addFace(v0b, v3b, v4b);
  model.addFace(v4b, v5b, v0b);
  
  //top
  //model.addFace(v0b, v5b, v6b);
  //model.addFace(v6b, v1b, v0b);
  
  //left
  model.addFace(v6b, v1b, v2b);
  model.addFace(v2b ,v7b, v6b);
  
  //bottom
  model.addFace(v7b, v2b, v3b);
  model.addFace(v3b, v4b, v7b);
  
  //back
  model.addFace(v5b, v6b, v7b);
  model.addFace(v7b, v4b, v5b);
  
  model.endShape();
  
  
  
  
  
//  model.add(Primitive.box(x,y,z));
//  model.translate(x-x2, y-y2, z-z2);
//  
//  model.add(Primitive.box();
//  model.translate();
//  
//  model.add(Primitive.box();
  
//  model.add(Primitive.box(x2-(x*2),y2-(y*2),z2-(z*2)));
//  model.translate(x2-x3, y2-y3, z2-z3);
//  
//  model.add(Primitive.box(x3-(x2*2),y3-(y2*2),z3-(z2*2)));

//  vl.add(x+offset, y+offset, z+offset);
//  vl.add(x+offset, y+offset, z-offset);
//  vl.add(x+offset, y-offset, z+offset);
//  vl.add(x-offset, y+offset, z+offset);
//
//  vl.add(x-offset, y-offset, z+offset);
//  vl.add(x-offset, y+offset, z-offset);
//  vl.add(x+offset, y-offset, z-offset);
//  vl.add(x-offset, y-offset, z-offset);
//  
//
//  
//  
//
//  vl.add(x2+offset, y2+offset, z2+offset);
//  vl.add(x2+offset, y2+offset, z2-offset);
//  vl.add(x2+offset, y2-offset, z2+offset);
//  vl.add(x2-offset, y2+offset, z2+offset);
//
//  vl.add(x2-offset, y2-offset, z2+offset);
//  vl.add(x2-offset, y2+offset, z2-offset);
//  vl.add(x2+offset, y2-offset, z2-offset);
//  vl.add(x2-offset, y2-offset, z2-offset);

//  Triangulate t = new Triangulate();
//  t.triangulate(vl.v);
  
//  model.add(vl);
//  
//  model.add(Primitive.box(10,10,10));
//  model.translate(-19,0,0);
//  
//  model.add(Primitive.box(10,10,10));
//  model.translate(-19,0,0);
//  model.add(Primitive.box(10,10,10));
//  model.translate(0,-19,0);
//  
//  model.add(Primitive.box(10,10,10));


  //  float x,y,z;
  //  
  //  // Create cylinder geometry
  //  // Parameters: w,h,detail, capped
  //  model=Primitive.cylinder(50,150,18, true);
  //  
  //  // Create sphere geometry
  //  // Parameters: rad,detail
  //  UGeometry sph=Primitive.sphere(50, 18);
  //  
  //  // translate and add sphere to cylinder.
  //  // note that Geometry.add() copies the faces rather than 
  //  // keep a reference to the original Geometry object
  //  sph.translate(0,150,0);
  //  model.add(sph);
  //  
  //  // a second translate and add() results in a second
  //  // sphere being added
  //  sph.translate(0,-300,0);
  //  model.add(sph);
  //  
  //  model.add(Primitive.box(150,25,25));
}

