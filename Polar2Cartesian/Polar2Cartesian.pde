float r = 75;
float theta = 0;

void setup() {
 size(640,360);
background(255); 
}

void draw() {
  
  float x = r * cos(theta);
  float y = r * sin(theta);
  
  noStroke();
  fill(0);
  ellipse(x+width/2, y+height/2, 16, 16);
  
  theta+= 0.01;
  
}
