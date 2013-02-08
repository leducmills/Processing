/**
 * SADbot Drawing Simulator
 * by Ben Leduc-Mills
 */
 

int direction;
float distance;
int lineX;
int lineY;
int border = 50;


void setup() {
 
 //size(screen.width, screen.height);
 size(800, 600);
 background(255);
 stroke(0);
 
 lineX = width/2;
 lineY = height/2;
 
}


void draw() {
  
  direction = int(random(1,5));
  distance = random(1,10);
  //println("distance" + distance);
  //println(direction);
  
  switch (direction) {
    
    case 1:
      if ((lineY + distance) < (height - border)) {
      down(distance);
      lineY += distance;
      
      }
    break;
    
    case 2:
      if ((lineY - distance) > border) {
      up(distance);
      lineY -= distance;
      //println("line Y:" + lineY);
      }
    break;

    case 3:
      if ((lineX - distance) > border) {
      left(distance);
      lineX -= distance;
      //println("line X:" + lineX);
      }
    break;

    case 4:
      if ((lineX + distance) <  (width - border)) {
      right(distance);
      lineX += distance;
      }
    break; 
 
    default:
      left(0);   
    
    
  }
  
}

void up( float distance ) {
  line(lineX, lineY, lineX, lineY - distance);
  
}

void down( float distance ) {
  line(lineX, lineY, lineX, lineY + distance);

}

void left( float distance ) {
  line(lineX, lineY, lineX - distance, lineY);
  
}

void right( float distance ) {
  line(lineX, lineY, lineX + distance, lineY);
 
}

void keyPressed() {
 
 if (key == 'c') {
    background(255); 
 }
 
 if (key == CODED) {
    if (keyCode == UP) {
      if ((lineY - distance) > border) {
      up(distance);
      lineY -= distance;
      }
    }
    if (keyCode == DOWN) {
      if ((lineY + distance) < (height - border)) {
       down(distance);
       lineY += distance;
      } 
    }
    if (keyCode == LEFT) {
      if ((lineX - distance) > border) {
       left(distance);
       lineX -= distance; 
      }
    }
    if (keyCode == RIGHT) {
      if ((lineX + distance) <  (width - border)) {
       right(distance); 
       lineX += distance;
      }
    }
 }
}

