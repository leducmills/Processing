int x,y,z;
boolean isOver;
float rotX, rotY;

void setup() {
  size(300,300,P3D);
  x = int(random(50,250));
  y = int(random(50,250));
  z = int(random(0,10));
}

void draw() {
  background(255);
  pushMatrix();
  translations();
  stroke(0);
  strokeWeight(4);
  point(x,y,z);
  mouseOver();
  popMatrix();
}

void mouseOver() {

  if (x > mouseX-3 && x < mouseX+3 &&  y > mouseY-3 && y < mouseY+3) {

    println("mouseover");
    isOver = true;
  }

  else isOver = false;
}

void mouseDragged() {

  if (isOver == true) {

    x = mouseX;
    y = mouseY;
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
