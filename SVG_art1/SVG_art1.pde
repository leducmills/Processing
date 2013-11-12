import org.philhosoft.p8g.svg.*;



//boolean doSave = false;


float x;
float y;

//float tx, ty;

float cycles;
int offset = 21;

PFont f;
PGraphics pg;
P8gGraphicsSVG svg; 

boolean doSave = false;

void setup() {

  background(255);
  noFill();
  //stroke(0);
  size(1400, 700);
  x = random(-300, 300);
  y = random(-300, 300);
  //beginRaw(PDF, "test3.pdf");
  f = createFont("Courier", 48);
  textFont(f);
  svg = (P8gGraphicsSVG) createGraphics(width, height, P8gGraphicsSVG.SVG);
  //svg.textMode(SHAPE);
  beginRecord(svg);
  //drawShape();
}

void draw() {
  translate(width/2, height/2);
  drawShape();

  //  //  if (doSave) {
  //  //   // beginRaw(PDF, selectOutput());
  //  //    PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, selectOutput()); 
  //  //    // set default Illustrator stroke styles and paint background rect.
  //  //    pdf.strokeJoin(MITER);
  //  //    pdf.strokeCap(SQUARE);
  //  //    //pdf.fill(0);
  //  //    pdf.noStroke();
  //  //    pdf.rect(0, 0, width, height);
  //  //  }
  //
  //  //frameRate(15);
  //  cycles = random(2, 8);
  //  translate(width/2, height/2, 0);
  //  pushMatrix();
  //  //background(255);
  //
  //  beginShape(TRIANGLE_STRIP);
  //  //beginShape(TRIANGLES);
  //  //strokeWeight(random(0.1, 2));
  //  strokeWeight(1);
  //  //fill(random(20,180));
  //  stroke(0);
  //  for ( int i = 0; i < cycles; i++) {
  //
  //    vertex(x, y);
  //
  //
  //    if ( (screenX(x, y)-50 < 0 || screenX(x, y)+50 > width) || (screenY(x, y)-50 < 0 || screenY(x, y)+50 > height)) {
  //      //      x = random(-300, 300);
  //      //      y = random(-300, 300);
  //      x = random(-10, 10);
  //      y = random(-10, 10);
  //    }
  //    else {
  //      x += random(-offset, offset);    
  //      y += random(-offset, offset);
  //
  //    }
  //  }
  //  endShape(CLOSE);
  //
  //  fill(255);
  //  noStroke();
  //  //ellipse(0, 0, 50, 50);
  //  textAlign(CENTER);
  //  text("testing", 0, 0);
  //  noFill();
  //  stroke(0);
  //
  //  popMatrix();
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
    doSave = true;
    //endRaw();
    //beginRaw(PDF, "test.pdf");
    //save("testing.pdf");
    svg.endRecord(sketchPath("svg1"));
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


void drawShape() {


  cycles = random(2, 8);
  //translate(width/2, height/2, 0);
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
      x = random(-10, 10);
      y = random(-10, 10);
    }
    else {
      x += random(-offset, offset);    
      y += random(-offset, offset);
    }
  }
  endShape(CLOSE);

  fill(255);
  noStroke();
  //ellipse(0, 0, 50, 50);
  textAlign(CENTER);
  text("testing", 0, 0);
  noFill();
  stroke(0);

  popMatrix();
}



