/* 
click/drag to rotate entire object
click/ drag onto vertices
*/

PGraphics3D p3d;

PMatrix3D proj = new PMatrix3D();
PMatrix3D cam = new PMatrix3D();
PMatrix3D modvw = new PMatrix3D();
PMatrix3D modvwInv = new PMatrix3D();
PMatrix3D screen2Model = new PMatrix3D();

// rotation
float rotX, rotY;

// arrays hold the vertices of 3d object
float[] vertices3D = new float[0];
int[] vertices2D = new int[0];

// index of current mouseover / clicked vertex
int vertexMouseOver = -1;
int vertexKlicked= -1;

// z value in model/world space of current vertex
float zModelMouseOver;
float zModelKlick;

void setup() {
  size(800, 600, P3D);
  p3d = (PGraphics3D)g;
  frameRate(50);
  
  //generate 6 vertices randomly
  for(int i=0;i<18;i++) {
      vertices3D = append(vertices3D, random(-200, 200));
    }
}

void draw() {
  background(255);
  
  // 3d object space begin
  pushMatrix();
  
  //apply mouse rotation and translation to center of screen
  translations();
  
  //get 3d matrices
  proj = p3d.projection.get();
  cam = p3d.camera.get();
  modvw = p3d.modelview.get();
  modvwInv = p3d.modelviewInv.get();
  
  //visualize 3d axes for orientation
  drawAxes3D();
  
  //visualize vertices
  drawVertSphere();
  drawVert();

  hitDetect();
  
  // calculate z value of picked vertex in model(world) space
  if (vertexMouseOver > -1) {
    zModelMouseOver = modelZ(vertices3D[vertexMouseOver], vertices3D[vertexMouseOver+1], vertices3D[vertexMouseOver+2]);
  }
  
  // 3d object space end
  popMatrix();

  drawHitDetect();
}

void mousePressed(){
  if (mouseButton==LEFT && vertexMouseOver>-1)
  {
    vertexKlicked = vertexMouseOver; 
    zModelKlick = zModelMouseOver;
    
    // calculate transformation matrix for projecting mouse coords
    // to the plane where the current selected vertex is
    // this doesn't work!
    screen2Model = modvwInv;
    screen2Model.apply(cam);
    //screen2Model.apply(proj);
    screen2Model.translate(0, 0, zModelKlick);
  } 
}

void mouseReleased(){
  vertexKlicked = -1;
}

void mouseDragged() {
    if (mouseButton==LEFT && vertexKlicked>-1) {
      float scrn[] = {mouseX, mouseY, 0};
      float model[] = new float[3];
      
      // apply transformation matrices to mouse coords
      screen2Model.mult(scrn, model);
      
      vertices3D[vertexKlicked] = model[0];
      vertices3D[vertexKlicked+1] = model[1];
      vertices3D[vertexKlicked+2] = model[2];
    } 
    else {
      // mouse controlled rotation
      float x1 = mouseX-pmouseX;
      float y1 = mouseY-pmouseY;
      rotX += -y1 * 0.01;
      rotY += x1 * 0.01;
    }
}


void translations() {
  translate(width/2, height/2);
  //mouse rotate
  rotateX(rotX);
  rotateY(rotY);
}

void drawAxes3D() {
  stroke(255,0,0);
  line(0,0,0, 100,0,0);
  stroke(0,255,0);
  line(0,0,0, 0,-100,0);
  stroke(0,0,255);
  line(0,0,0, 0,0,100);
}

void drawVertSphere() {
  //3d vertices3D as spheres
  noStroke();
  fill(100);
  sphereDetail(4);
  for(int i=0; i<vertices3D.length; i=i+3)
  {
    pushMatrix();
    translate(vertices3D[i], vertices3D[i+1], vertices3D[i+2]);
    sphere(3);
    popMatrix();
  }
}

void drawVert() {
  noFill();
  stroke(100, 100, 100);
  beginShape();
  for(int i=0; i<vertices3D.length; i=i+3)
  {
    vertex(vertices3D[i], vertices3D[i+1], vertices3D[i+2]);
  }
  endShape();
}

void hitDetect() {
  // mouse hit detection using screnX, screenY
  vertices2D = new int[0];
  vertexMouseOver = -1;
  
  for(int i=0; i<vertices3D.length; i=i+3) {
    int x = int(screenX(vertices3D[i], vertices3D[i+1], vertices3D[i+2]));
    int y = int(screenY(vertices3D[i], vertices3D[i+1], vertices3D[i+2]));
    
    vertices2D = append(vertices2D, x);
    vertices2D = append(vertices2D, y);
    
    if (x > mouseX-3 && x < mouseX+3 && y > mouseY-3 && y < mouseY+3) {
       vertexMouseOver = i;
    }
  }
}

void drawHitDetect() {
   if (vertexKlicked > -1) {
     stroke(255, 0, 0);
     noFill();
     ellipse(vertices2D[vertexKlicked/3*2], vertices2D[vertexKlicked/3*2+1], 30, 30);
   } else if (vertexMouseOver > -1) {
     stroke(100, 100, 100);
     noFill();
     ellipse(vertices2D[vertexMouseOver/3*2], vertices2D[vertexMouseOver/3*2+1], 20, 20);
   }
}
