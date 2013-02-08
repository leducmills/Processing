void simpleImage(int r, int g, int b, int a) {
  image(img01, width/4, height/4, width/2, height/2);
  image(img02, 0, 0, 200, 200);
  image(img03, 300, 300, 100, 100);
  point(50, 100);
  stroke(200, 0, 200, 100);
  line(50, 100, 150, 200);
  stroke(0);
  fill(r, g, b, a);
  ellipse(200, 200, 30, 30);
  fill(255, 0, 0);
  triangle(400, 500, 500, 600, 600, 400);
}

void simpleImage(int r, int g, int b) {
  image(img01, width/4, height/4, width/2, height/2);
  image(img02, 0, 0, 200, 200);
  image(img03, 300, 300, 100, 100);
  point(50, 100);
  stroke(200, 0, 200, 100);
  line(50, 100, 150, 200);
  stroke(0);
  fill(r, g, b);
  ellipse(x, y, x, y);
  fill(r, g, b);
  triangle(x, y, 500, 600, 600, 400);
}

void simpleImage(int backgnd) {
  if (backgnd == 1) {
    image(img01, 0, 0);
  }
  if (backgnd == 2) {
    image(img02, 0, 0);
  }
  if (backgnd == 3) {
    image(img03, 0, 0);
  }
}















