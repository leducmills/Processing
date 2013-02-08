import processing.opengl.*;
import toxi.processing.*;
import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;

Mesh3D mesh = new TriangleMesh();
Vec3D[] vectors = new Vec3D[0];
int spacing = 50;
ToxiclibsSupport gfx;

void setup() {
  size(800, 600, OPENGL);
  gfx = new ToxiclibsSupport(this);

  initVects();

  //TriangleMesh mySTL = new TriangleMesh();

  for (int i = 0; i < vectors.length; i+=3) {

    //scale(.05);
    mesh.addFace(vectors[i], vectors[i+1], vectors[i+2]);
    // println(vectors[i] + " " + vectors[i+1] + " " + vectors[i+2]);
  }

  mesh.computeVertexNormals();
  //mySTL.addMesh(mesh);
}

void draw() {
  background(0);
  camera(width / 2 - mouseX, height / 2 - mouseY, 400, 0, 0, 0, 0, 1, 0);
  lights();
  gfx.mesh(mesh, false, 10);
}


void initVects() {

  int numCoords = 30;


  for (int i = 0; i < numCoords; i++) {

    int x = (int)(random(0, 7));
    int y = (int)(random(0, 7));
    int z = (int)(random(0, 7));

    Vec3D tempVect = new Vec3D(x * spacing, y * -spacing, z * spacing);

    vectors = (Vec3D[])append(vectors, tempVect);
  }
}

