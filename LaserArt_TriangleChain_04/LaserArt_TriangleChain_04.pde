import processing.svg.*;

boolean startRecord;
boolean endRecord;

int cycles;
int maxVertexLength;
int boundary;

float startX = 0;
float startY = 0;

float GX;
float GY;

int shapeType = TRIANGLE_STRIP;

PFont f;



void setup() {
   size(1400, 700, P2D);
   frameRate(10);
   
   background(255);
   noFill();
   
   printArray(PFont.list());
   f = createFont("Helvetica", 96);
   textFont(f);

   
   //translate(width/2, height/2);
   //pushMatrix();
   
   boundary = 150;
   maxVertexLength = 50;
   
   GX = startX;
   GY = startY;
   
   startRecord = true;
   endRecord = false;
   
   if (startRecord) {
     beginRaw(SVG, genFilename()); 
     startRecord = false;
  }
   
}

void draw() {
 
  cycles = (int)random(15,35);
  translate(width/2, height/2);
  pushMatrix();
  
  beginShape(shapeType); // TRIANGLE_STRIP = 10, QUADS = 17 TRIANGLES = 9 POINTS = 3 TRIANGLE_FAN =11
  
  strokeWeight(1);
  stroke(0);
  for (int i = 0; i < cycles; i++) {
      drawTriangleStrip(GX, GY);
  }
  maxVertexLength = (int)random(5, 50);
  endShape(CLOSE);
  
  fill(255);
  textAlign(CENTER);
  text("jameson", 0, 0);
  noFill();
  
  
  popMatrix();
  
  if (endRecord) {
     endRaw();
     endRecord = false;
  }
  
}

void keyPressed() {
  if (key == 'r') {
     endRecord = !endRecord;
  }
  if (key == 'q') {
     exit(); 
  }
  if (key == 'c') {
     if (!endRecord) {
        endRaw();
        endRecord = false;
        background(255); 
        beginRaw(SVG, genFilename());      
     }
     
  }
  
  if (key == '1') {
     shapeType = TRIANGLES; 
  }
  if (key == '2') {
     shapeType = TRIANGLE_STRIP; 
  }
  if (key == '3') {
     shapeType = TRIANGLE_FAN; 
  }
  if (key == '4') {
     shapeType = QUAD; 
  }
  if (key == '5') {
     shapeType = QUAD_STRIP; 
  }
  if (key == '6') {
     shapeType = POINTS; 
  }
  if (key == '7') {
     shapeType = LINES; 
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
       startY -= 50;
       GY -= 50;
    }
    if (keyCode == DOWN) {
       startY += 50;
       GY += 50;
    }
    if (keyCode == RIGHT) {
       startX += 50;
       GX =+ 50;
    }
    if (keyCode == LEFT) {
       startX -= 50;
       GX -= 50;
    }
  }
}

void drawTriangleStrip(float x, float y) {
 
  vertex(GX,GY);
  
  if (!isInBounds(GX,GY)) {
     GX = startX;
     GY = startY;
  } else {
     GX += random(-maxVertexLength, maxVertexLength);
     GY += random(-maxVertexLength, maxVertexLength);
  } 
}


boolean isInBounds(float x, float y) {
    if (screenX(GX, GY) - boundary < 0 ||
        screenX(GX, GY) + boundary > width ||
        screenY(GX, GY) - boundary < 0 ||
        screenY(GX, GY) + boundary > height ){
        return false;  
    }
    else {
        return true;   
    }      
}

String genFilename() {
  int d = day();    // Values from 1 - 31
  int m = minute();  // Values from 1 - 12
  int h = hour();   // 2003, 2004, 2005, etc.
  int s = second();
  String fileName = String.valueOf(d) + 
  String.valueOf(m) + String.valueOf(h) + 
  String.valueOf(s) + ".svg";
  return fileName;
  
}
