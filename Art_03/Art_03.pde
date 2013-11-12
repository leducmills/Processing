import processing.pdf.*;

//boolean doSave = false;


float x;
float y;
float z;

float tx, ty;

float cycles;
int offset = 21;

PFont f;
PGraphics pg;

void setup() {

  background(255);
  noFill();
  //stroke(0);
  size(1400, 700, P2D);
  //size(900,150,P3D);
  x = random(-300, 300);
  y = random(-300, 300);
  z = 0;
  
  int d = day();    // Values from 1 - 31
  int m = minute();  // Values from 1 - 12
  int h = hour();   // 2003, 2004, 2005, etc.
  int s = second();
  
  String fileName = String.valueOf(d) + String.valueOf(m) + String.valueOf(h) + String.valueOf(s) + ".pdf";
  
  beginRecord(PDF, fileName);

  tx = 0;
  ty = 10000;

  f = createFont("Courier", 48);
  textFont(f);
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
  cycles = random(2, 8);
  translate(width/2, height/2);
  pushMatrix();
  //background(255);

  beginShape(TRIANGLE_STRIP);
  //beginShape(TRIANGLES);
  //strokeWeight(random(0.1, 2));
  strokeWeight(1);
  //fill(random(20,180));
  stroke(0);
  for ( int i = 0; i < cycles; i++) {

    vertex(x, y);


    if ( (screenX(x, y)-50 < 0 || screenX(x, y)+50 > width) || (screenY(x, y)-50 < 0 || screenY(x, y)+50 > height)) {
      //      x = random(-300, 300);
      //      y = random(-300, 300);
      x = random(550, 600);
      y = random(100, 150);
    }
    else {
      x += random(-offset, offset);    
      y += random(-offset, offset);
      //      x = map(noise(tx), 0, 1, -1*width/2, width/2);
      //      y = map(noise(ty), 0, 1, -1*height/2, height/2);
      //
      //      tx += 0.25;
      //      ty += 0.25;
    }
  }
  endShape(CLOSE);

  fill(255);
  noStroke();
  ellipse(575, 125, 50, 50);
  //textAlign(CENTER);
  //text("LOVE", 0, 0);
  noFill();
  stroke(0);

  popMatrix();

}



void keyPressed() {
  if (key == 'r') {
    //    x = random(-300, 300);
    //    y = random(-300, 300);
    x = 0;
    y = 0;
    background(255);
    println(x + " " + y);
  }
  if (key == 's') {
    //doSave = true;
    //endRaw();
    //beginRaw(PDF, "test.pdf");
    //save("testing.pdf");
    endRecord();
    background(255);
  }
  if (key == 'q') {
    endRaw();
    exit();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      //z -= 100;
      y -= 40;
      println(y);
    }
    if (keyCode == DOWN) {
      //z += 100;
      y +=40;
      println(y);
    }
    if (keyCode == RIGHT) {
      x += 40;
      println(x);
    }
    if (keyCode == LEFT) {
      x -= 40;
      println(x);
    }
  }
}



void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}

