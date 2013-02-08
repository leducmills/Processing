// this class calculates a 3D terrain using the noise(x,y)
// function. see http://processing.org/reference/noise_.html
// for more information about noise().
//
// because the user might change grid resolution or the X and Y
// modifiers for the noise function, the Terrain.draw() function
// needs to be able to regenerate the mesh and calculate the
// Z heights every frame.

class Terrain {
  Pt pt[][];
  int gridRes; // grid resolution
  int lastGridRes; // last known grid resolution
  float noiseStart,noiseX,noiseY;
  
  Terrain() {
    // set offset for noise function
    noiseStart=random(1000);    
    
    generateMesh();
  }
  
  // generate new mesh at current grid resolution
  void generateMesh() {
    float D;
   
    gridRes=int(slGridResolution);
    lastGridRes=gridRes;
 
    pt=new Pt[gridRes][gridRes];
    
    // D is the distance between each vertex, calculated
    // as 80% of width, divided by gridRes minus one
    D=(float)width*0.8f;
    D=D/(float)(gridRes-1);
    
    for(int i=0; i<gridRes; i++) {
      for(int j=0; j<gridRes; j++) {
        // generate new verex
        pt[i][j]=new Pt(
          (float)i*D,
          (float)j*D,
          0);
          
        // center the vertex
        pt[i][j].x=pt[i][j].x-(float)(gridRes-1)*0.5*D;
        pt[i][j].y=pt[i][j].y-(float)(gridRes-1)*0.5*D;
      }
    }
  }
  
  // we need to calculate the Z values every frame to respond to
  // user manipulation 
  void calculateZ() {
    noiseX=noiseStart;
    for(int i=0; i<gridRes; i++) {
      noiseY=0;
      
      for(int j=0; j<gridRes; j++) {
        pt[i][j].z=noise(noiseX,noiseY)*Z-Z*0.5;          
        noiseY+=(noiseYD/(float)gridRes)*0.1;
      }
      
      noiseX+=(noiseXD/(float)gridRes)*0.1;    
    }
  }
  
  void draw() {
    // check if grid resolution has changed, if so regenerate mesh
    gridRes=int(slGridResolution);
    if(lastGridRes!=gridRes) generateMesh(); 
    
    // calculate the Z positions
    calculateZ();

    // check which drawing style to use
    if(toggleSolid) drawSolid();
    else drawLines();    
  }
  
  // draw mesh as horizontal lines
  void drawLines() {
    stroke(0);
  
    for(int i=0; i<gridRes; i++) {
      noFill();
      beginShape();
      for(int j=0; j<gridRes; j++) {
        vertex(pt[i][j].x,pt[i][j].y,pt[i][j].z);
      }
      endShape();
    }
  }

  // draw mesh surface as strips of quads
  void drawSolid() {
    float bottomZ;
    float colFract;
    
    bottomZ=-Z*0.5;
    
    noStroke();
    for(int i=0; i<gridRes-1; i++) {
      beginShape(QUAD_STRIP);
      for(int j=0; j<gridRes; j++) {
        setColorZ(pt[i][j].z);
        vertex(pt[i][j].x,pt[i][j].y,pt[i][j].z);
        
        setColorZ(pt[i+1][j].z);
        vertex(pt[i+1][j].x,pt[i+1][j].y,pt[i+1][j].z);
      }
      endShape();
    }
    
    // draw edges of the mesh
    
    fill(#e56000);
    stroke(255);
    
    // left edge
    beginShape(QUAD_STRIP);
    for(int i=0; i<gridRes; i++) {
      vertex(pt[0][i].x,pt[0][i].y,bottomZ);
      vertex(pt[0][i].x,pt[0][i].y,pt[0][i].z);
    }
    endShape();

    // right side
    beginShape(QUAD_STRIP);
    for(int i=0; i<gridRes; i++) {
      vertex(pt[gridRes-1][i].x,pt[gridRes-1][i].y,pt[gridRes-1][i].z);
      vertex(pt[gridRes-1][i].x,pt[gridRes-1][i].y,bottomZ);
    }
    endShape();

    // lower edge
    beginShape(QUAD_STRIP);
    for(int i=0; i<gridRes; i++) {
      vertex(pt[i][gridRes-1].x,pt[i][gridRes-1].y,pt[i][gridRes-1].z);
      vertex(pt[i][gridRes-1].x,pt[i][gridRes-1].y,bottomZ);
    }
    endShape();

    // top edge
    beginShape(QUAD_STRIP);
    for(int i=0; i<gridRes; i++) {
      vertex(pt[i][0].x,pt[i][0].y,pt[i][0].z);
      vertex(pt[i][0].x,pt[i][0].y,bottomZ);
    }
    endShape();
    
    // bottom plane
    beginShape(QUADS);
    vertex(pt[0][0].x,pt[0][0].y,bottomZ);
    vertex(pt[gridRes-1][0].x,pt[gridRes-1][0].y,bottomZ);
    vertex(pt[gridRes-1][gridRes-1].x,pt[gridRes-1][gridRes-1].y,bottomZ);
    vertex(pt[0][gridRes-1].x,pt[0][gridRes-1].y,bottomZ);
    endShape();      
  }
  
  void setColorZ(float z) {
    // set color as a function of Z position
    float colFract=(z+Z*0.5)/Z;
    fill(25,
      50+75*colFract,
      80+175*colFract);
  } 
}
