void buildMesh() {

  int offset = 10;

  float x = 0;
  float y = 0;
  float z = 0;
  Vec3D vec = new Vec3D(x, y, z);

  float x2 = 0;
  float y2 = -100;
  float z2 = 0;
  Vec3D vec2 = new Vec3D(x2, y2, z2);

  //box around point1
  Vec3D v0a = new Vec3D(x+offset, y+offset, z+offset);
  Vec3D v1a = new Vec3D(x-offset, y+offset, z+offset);
  Vec3D v2a = new Vec3D(x-offset, y-offset, z+offset);
  Vec3D v3a = new Vec3D(x+offset, y-offset, z+offset);
  Vec3D v4a = new Vec3D(x+offset, y-offset, z-offset);
  Vec3D v5a = new Vec3D(x+offset, y+offset, z-offset);
  Vec3D v6a = new Vec3D(x-offset, y+offset, z-offset);
  Vec3D v7a = new Vec3D(x-offset, y-offset, z-offset);

  //box around point2
  Vec3D v0b = new Vec3D(x2+offset, y2+offset, z2+offset);
  Vec3D v1b = new Vec3D(x2-offset, y2+offset, z2+offset);
  Vec3D v2b = new Vec3D(x2-offset, y2-offset, z2+offset);
  Vec3D v3b = new Vec3D(x2+offset, y2-offset, z2+offset);
  Vec3D v4b = new Vec3D(x2+offset, y2-offset, z2-offset);
  Vec3D v5b = new Vec3D(x2+offset, y2+offset, z2-offset);
  Vec3D v6b = new Vec3D(x2-offset, y2+offset, z2-offset);
  Vec3D v7b = new Vec3D(x2-offset, y2-offset, z2-offset);

  //cube1
  //front
  mesh.addFace(v0a, v1a, v2a);
  mesh.addFace(v2a, v3a, v0a);

  //right
  mesh.addFace(v0a, v3a, v4a);
  mesh.addFace(v4a, v5a, v0a);

  //top
  mesh.addFace(v0a, v5a, v6a);
  mesh.addFace(v6a, v1a, v0a);

  //left
  mesh.addFace(v6a, v1a, v2a);
  mesh.addFace(v2a, v7a, v6a);

  //bottom
  mesh.addFace(v7a, v2a, v3a);
  mesh.addFace(v3a, v4a, v7a);

  //back
  mesh.addFace(v5a, v6a, v7a);
  mesh.addFace(v7a, v4a, v5a);


  //  //exact points for lerped rect
  //  //front
  //  mesh.addFace(v2a, v3a, v0b);
  //  mesh.addFace(v0b, v1b, v2a);
  //  
  //  //right
  //  mesh.addFace(v3a, v4a, v5b);
  //  mesh.addFace(v5b, v0b, v3a);
  //  
  ////  //top
  ////  model.addFace(v0a, v5a, v6a);
  ////  model.addFace(v6a, v1a, v0a);
  //  
  //  //left
  //  mesh.addFace(v2a, v7a, v6b);
  //  mesh.addFace(v6b ,v1b, v2a);
  //  
  ////  //bottom
  ////  model.addFace(v7a, v2a, v3a);
  ////  model.addFace(v3a, v4a, v7a);
  //  
  //  //back
  //  mesh.addFace(v7a, v4a, v5b);
  //  mesh.addFace(v5b, v6b, v7a);


  //cube2
  //front
  mesh.addFace(v0b, v1b, v2b);
  mesh.addFace(v2b, v3b, v0b);

  //right
  mesh.addFace(v0b, v3b, v4b);
  mesh.addFace(v4b, v5b, v0b);

  //top
  mesh.addFace(v0b, v5b, v6b);
  mesh.addFace(v6b, v1b, v0b);

  //left
  mesh.addFace(v6b, v1b, v2b);
  mesh.addFace(v2b, v7b, v6b);

  //bottom
  mesh.addFace(v7b, v2b, v3b);
  mesh.addFace(v3b, v4b, v7b);

  //back
  mesh.addFace(v5b, v6b, v7b);
  mesh.addFace(v7b, v4b, v5b);

  float d = vec.distanceTo(vec2);
  float lerps = d / offset;
  println(lerps);
  float lx, ly, lz = 0;

  for (int i = 1; i < lerps+1; i++) {
    
    lx = (x-x2)/lerps * i;
    ly = (y-y2)/lerps * -i;
    lz = (z-z2)/lerps * i;
    //println(lz);
      
    Vec3D lerped = new Vec3D(lx, ly, lz);

    Vec3D v0l = new Vec3D(lx+offset, ly+offset, lz+offset);
    Vec3D v1l = new Vec3D(lx-offset, ly+offset, lz+offset);
    Vec3D v2l = new Vec3D(lx-offset, ly-offset, lz+offset);
    Vec3D v3l = new Vec3D(lx+offset, ly-offset, lz+offset);
    Vec3D v4l = new Vec3D(lx+offset, ly-offset, lz-offset);
    Vec3D v5l = new Vec3D(lx+offset, ly+offset, lz-offset);
    Vec3D v6l = new Vec3D(lx-offset, ly+offset, lz-offset);
    Vec3D v7l = new Vec3D(lx-offset, ly-offset, lz-offset);

    //front
    mesh.addFace(v0l, v1l, v2l);
    mesh.addFace(v2l, v3l, v0l);

    //right
    mesh.addFace(v0l, v3l, v4l);
    mesh.addFace(v4l, v5l, v0l);

    //top
    mesh.addFace(v0l, v5l, v6l);
    mesh.addFace(v6l, v1l, v0l);

    //left
    mesh.addFace(v6l, v1l, v2l);
    mesh.addFace(v2l, v7l, v6l);

    //bottom
    mesh.addFace(v7l, v2l, v3l);
    mesh.addFace(v3l, v4l, v7l);

    //back
    mesh.addFace(v5l, v6l, v7l);
    mesh.addFace(v7l, v4l, v5l);
  }
}

