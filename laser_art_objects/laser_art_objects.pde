import processing.pdf.*;

MShape s1, s2, s3, s4;
boolean doSave = false;

void setup() {
  size(1200,300, P3D);
  background(255);
  noFill();
  s1 = new MShape(50, -200, 200, -80, 80, -50, 50, 1.5);
  s2 = new MShape(100, -500, 500, -90, 90, -50, 50, .5);
  s3 = new MShape(50, -50, 50, -50, 50, -50, 50, 2);
  s4 = new MShape(70, -400, 400, -50, 50, -50, 50, 1); 
}

void draw() {
  //noLoop();
  //smooth();
  if (doSave) {
    PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput()); 
    // set default Illustrator stroke styles and paint background rect.
    pdf.strokeJoin(MITER);
    pdf.strokeCap(SQUARE);
    //pdf.fill(0);
    pdf.noStroke();
    pdf.rect(0,0, width,height);
  }
  
  pushMatrix();
  background(255);
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  s1.display();
  s2.display();
  s3.display();
  s4.display();
  popMatrix();
  
  if(doSave) {
    endRaw();
    doSave=false;
  }
  
}


class MShape {

  int numPoints;
  int xMax, xMin;
  int yMax, yMin;
  int zMax, zMin;
  float strokeW;

  MShape(int inumPoints, int ixMin, int ixMax, int iyMin, int iyMax, int izMin, int izMax, float istrokeW) {

    numPoints = inumPoints;
    xMin = ixMin;
    xMax = ixMax;
    yMin = iyMin;
    yMax = iyMax;
    zMin = izMin;
    zMax = izMax;
    strokeW = istrokeW;
  }

  void display() {

    beginShape();
    strokeWeight(strokeW); 
    for( int i = 0; i < numPoints; i++) {
      
      int randX = int(random(xMin, xMax));
      int randY = int(random(yMin, yMax));
      int randZ = int(random(zMin, zMax));
      vertex(randX, randY, randZ);
    }
    endShape();
  }
}

void keyPressed() {
  if (key == 's') { 
    doSave=true;
  }
}
