import processing.pdf.*;

//boolean doSave = false;


float x;
float y;
float z;

float cycles;

void setup() {

  background(255);
  noFill();
  //stroke(0);
  size(1440, 960, P3D);
  //size(900,150,P3D);
  x = random(-300, 300);
  y = random(-300, 300);
  z = 0;
  beginRaw(PDF, selectOutput());
}

void draw() {

  //  if (doSave) {
  //   // beginRaw(PDF, selectOutput());
  //    PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput()); 
  //    // set default Illustrator stroke styles and paint background rect.
  //    pdf.strokeJoin(MITER);
  //    pdf.strokeCap(SQUARE);
  //    //pdf.fill(0);
  //    pdf.noStroke();
  //    pdf.rect(0, 0, width, height);
  //  }

  frameRate(15);

  cycles = random(3, 100);
  translate(width/2, height/2, 0);
  pushMatrix();
  //background(255);

  beginShape(TRIANGLE_STRIP);
  //beginShape(TRIANGLES);
  //strokeWeight(random(0.1, 2));
  strokeWeight(1);
  //fill(random(20,180));
  stroke(random(80,220));
  for ( int i = 0; i < cycles; i++) {

    vertex(x, y, z);

    x += random(-15, 15);    
    y += random(-15, 15);
  }
  endShape(CLOSE);
  popMatrix();



  //  if (doSave) {
  //    endRaw();
  //    doSave=false;
  //  }
}



void keyPressed() {
  if (key == 'r') {
    x = random(-300, 300);
    y = random(-300, 300);
    println(x + " " + y);
  }
  if (key == 's') {
    //doSave = true;
    background(255);
  }
  if (key == 'q') {
    endRaw();
    exit();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      z -= 100;
      y -= 100;
      println(y);
    }
    if (keyCode == DOWN) {
      z += 100;
      y +=100;
      println(y);
    }
    if (keyCode == RIGHT) {
      x += 100;
      println(x);
    }
    if (keyCode == LEFT) {
      x -= 100;
      println(x);
    }
  }
}

