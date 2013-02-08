void setup() {
  size(480, 800);

  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point
};

void draw() {
  background(#FF9900);
  rect(width/2, height/2, 150, 150);
};

