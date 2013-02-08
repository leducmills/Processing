//int xval = 4;
//int yval = 5;
//int zval = 3;
//  
//float xpos = 10;
//float ypos = 10;
//float zpos = 10;

float depth = 400;

void setup() {
  size(640, 360, P3D);
  //noStroke();
  stroke(0);
  background(255);

  
}

void draw() {

  int xval = 4;
  int yval = 5;
  int zval = 3;
  
  float xpos = 10;
  float ypos = 10;
  float zpos = 10;
  
  
  //translate(width/2, height/2, -depth);
  
  for( float i = 0; i <= zval; i ++) {
    point(xpos, ypos, zpos);
    
   for (float j = 0; j <= yval; j ++) {
     point(xpos, ypos, zpos);
    
    for (int k = 0; k < 5; k++) {
      point(xpos, ypos, zpos);
      xpos += 10;
      ypos += 10;
      zpos += 10;
    }
   }
  }
   
   
}  
