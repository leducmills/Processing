import processing.pdf.*;

int numLines = int(random(10,300));
int numSpheres = int(random(10, 100));
boolean dosave=false;
PFont myFont; //init font for text

void setup() {
  size(1200, 600, P3D);
  hint(ENABLE_NATIVE_FONTS);
  //textMode(SHAPE);
  String[] fontList = PFont.list();
  println(fontList);
  myFont = createFont("Serif", 32);
  textFont(myFont);
  background(255);  
}


void draw() {
  //noLoop();
  
  if(dosave) {
   
   //PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput());
   PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput()); 
    // set default Illustrator stroke styles and paint background rect.
    pdf.strokeJoin(MITER);
    pdf.strokeCap(SQUARE);
    //pdf.fill(0);
    pdf.noStroke();
    pdf.rect(0,0, width,height);
    
  }
  
  
  translate(width/2,height/2,0);
  pushMatrix();
  
  rotateY(frameCount * 0.01);
  background(255);
  //drawLines();
  //drawCircles();
  drawBoxes();
  fill(0);
  text("10100111101010100100010101", 0, 0);
  popMatrix();
  
if(dosave) {
    endRaw();
    dosave=false;
  }
  
}

void drawLines() {
 
  beginShape();
  
  for( int i = 0; i < numLines; i++) {
    strokeWeight(random(3));
    int randX = int(random(10,1190));
    int randY = int(random(10,290));
    int randZ = int(random(-100,200));
    vertex(randX, randY, randZ);
    
  }
  
  endShape();
  
}

void drawBoxes() {
 
  int randNum = int(random(1,100));
  noFill();
  rotateX(frameCount * 0.02);
  
  for( int i = 0; i < randNum; i++) {
    
    int randX = int(random(10,1190));
    int randY = int(random(10,290));
    int randZ = int(random(-100,200));
    box(randX, randY, randZ);
    
  }
  
}


void drawCircles() {
 
  for ( int j = 0; j < numSpheres; j++){
    noFill();
    stroke(0);
    strokeWeight(random(3));
    int randX = int(random(10,1190));
    int randY = int(random(10,290));
    ellipse(randX, randY, randX, randX); 
 }
 
  
}

void keyPressed() {
  if (key == 's') { 
    dosave=true;
  }
}
