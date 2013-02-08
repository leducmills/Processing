// MeshLibDemo.pde - Demo of Lee Byron's Mesh library for
// calculating and drawing Voronoi, Delaunay and Convex Hull 
// diagrams. 

// Uses a set of random points to calculate all 
// three diagrams, with one point responding to the mouse
// position. Press space to reset points, press '1', '2' and 
// '3' to toggle display of the different diagrams.
// 
// The library is included in this sketch, see the "libraries"
// subfolder See http://leebyron.com/else/mesh/ for more
// information about the library.
//
// Marius Watz - http://workshop.evolutionzone.com/

import megamu.mesh.*;

Voronoi myVoronoi;
Delaunay myDelaunay;
Hull myHull;

float[][] points;
float[][] myEdges;
MPolygon myRegions[],myHullRegion;
int col[];

float startX,startY,endX,endY;
float[][] regionCoordinates;

boolean showVoronoi=true;
boolean showDelaunay=false;
boolean showHull=false;

void setup() {			
  size(500,250);
  
  // initialize points and calculate diagrams
  initMesh();
  smooth();
}

void draw() {
  background(200);
  if(myRegions==null) return;

  // draw Voronoi
  if(showVoronoi) {
    strokeWeight(1);
    stroke(0);
    for(int i=0; i<myRegions.length; i++) {
      fill(col[i]); // use random color for each region
      regionCoordinates = myRegions[i].getCoords();
      myRegions[i].draw(this); // draw this shape
    }
  }
  
  // draw Voronoi as lines
  if(showDelaunay) {
    strokeWeight(2);
    stroke(255,0,0);
    for(int i=0; i<myEdges.length; i++) {
      startX = myEdges[i][0];
      startY = myEdges[i][1];
      endX = myEdges[i][2];
      endY = myEdges[i][3];
      line(startX, startY, endX, endY);
    }
  }
  
  // draw Hull in semi-transparent yellow
  if(showHull) {
    strokeWeight(1);
    stroke(0);
    fill(255,255,0, 150);
    myHullRegion.draw(this);
  }
}

void initMesh() {
  // is points array is null then initialize it
  if(points==null) initPoints();
  
  // save the current number of regions, so that
  // we can check if it's the same after the Voronoi
  // has been recalculated.
  int oldlength=0;
  if(myRegions!=null) oldlength=myRegions.length;

  myVoronoi = new Voronoi( points );
  myHull = new Hull( points );
  myDelaunay = new Delaunay( points );

  myRegions = myVoronoi.getRegions();
  myHullRegion = myHull.getRegion();
  myEdges = myDelaunay.getEdges();

  // if the number of regions is different than
  // before then recalculate the random colors
  if(oldlength!=myRegions.length) {
    col=new int[myRegions.length];
    for(int i=0; i<myRegions.length; i++) {
      float prob=random(100);
      if(prob>60) col[i]=color(random(30,100));    
      else col[i]=color(random(200,255));   
    }
    col[0]=color(255,0,0);
  }
}

void initPoints() {
    points = new float[(int)random(5,30)][2];

  for(int i=0; i<points.length; i++) {
    points[i][0] = random(width); // first point, x
    points[i][1] = random(height); // first point, y
  }

}

void keyPressed() {
  // reset points and mesh when spacebar is pressed
  if(key==' ') {
    initPoints();
    initMesh();
  }
  
  // use keys '1'-'3' to toggle display
  if(key=='1') showVoronoi=!showVoronoi;
  if(key=='2') showDelaunay=!showDelaunay;
  if(key=='3') showHull=!showHull;
}

void mouseMoved() {
  // if myRegions is null then mesh is not ready
  if(myRegions==null) return;

  // set first point to mouse position and recalculate
  points[0][0]=mouseX;
  points[0][1]=mouseY;
  initMesh();
}
