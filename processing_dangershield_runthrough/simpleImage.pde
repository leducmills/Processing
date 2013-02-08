void simpleImage(int myred, int mygreen, int myblue) {
  image(img1, 0, 0);
  point(100, 100);
  fill(myred, mygreen, myblue, 255);
  stroke(255, 0, 0);
  line(100, 100, 200, 200);
  strokeWeight(10);
  stroke(0);
  ellipse(100, 100, 50, 50);
}

