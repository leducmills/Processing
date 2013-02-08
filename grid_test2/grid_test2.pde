
int gridSize = 10;


void setup() {
 
 size(400, 300, P3D);

  
}


void draw() {
  background(255);
  
  
  translate(width/2, height/2, -100);
  rotateX(mouseY/10);
  rotateY(mouseX/10);
  
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;
  
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      for( int k = 0; k < gridSize; k++) {
        point(xpos, ypos, zpos);
        xpos += 10; 
      }
      xpos = 0;
      ypos +=10;   
    }
    xpos = 0;
    ypos = 0;
    zpos += 10; 
  }
}


