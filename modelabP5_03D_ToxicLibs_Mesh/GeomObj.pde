class GeomObj {
  Vec3D pos,dir; // 3D vectors to store position, dimensions and directions
  Mesh3D mesh; // TriangleMesh stores 3D mesh data
  int col;
  float l,r1,r2;

  GeomObj() { // GeomObj constructor
  
    // randomize color
    col=color(random(50,255));    

    // randomize length and radius 1 & 2
    l=random(30,100);
    if(random(100)>90) l+=100;
    
    r1=random(10,30); 
    r2=5;

    // create new random position as a Vec3D object
    pos=new Vec3D(50+l*0.5,0,0);    
    pos.rotateY(random(TWO_PI));
    pos.rotateX(random(TWO_PI));

    // create random point to point the box towards
    dir=new Vec3D(pos);
    dir.normalize();
    
    // calculate mesh of cone
    mesh=(TriangleMesh)new Cone(pos, dir, r1,r2,l).toMesh(36);
    
    // add mesh of a second cone with slightly longer length 
    // and smaller top radius
    mesh.addMesh(new Cone(pos, dir, r1*0.5,r2,l*1.25).toMesh(36));
  }
  
  public void draw() {
    fill(col);
    
    // use ToxiclibsSupport.mesh() to draw mesh
    gfx.mesh(mesh);
  }
  
}


