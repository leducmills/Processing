int [][][] points = new int[10][2][2];

void setup() {
 
 size(400,400,P3D);
 
 initPoints();
 //print(points.length);
 background(255);
 smooth();
 
}

void draw() {
  
  background(255);
  translate(width/2, height/2, 0);
   
  if(points==null) initPoints();
  
  rotateY(frameCount * 0.01);
  strokeWeight(3);
  
  
  beginShape();
  
  for( int j = 0; j < points.length; j++) {
   
    point(points[j][0][0], points[j][0][1], points[j][1][0]);
    //println(points[j][0][0] + "," + points[j][0][1] + "," + points[j][1][0]);
  }
  
  endShape();
  
  
}


void initPoints() {
  
  for( int i = 0; i < points.length; i++) {
  
  points[i][0][0] = (int)random(4) * 10;
  points[i][0][1] = (int)random(4) * 10;
  points[i][1][0] = (int)random(4) * 10;
  
  println(points[i][0][0] + "," + points[i][1][0] + "," + points[i][0][1]);
    
 }  
}


void buildHull() {
 
 if( points.length < 4) return null;
 
 int current = 0;
 
 for(int k = 0; k < points.length; k++) {
  
   current = points[k][1][0];
   
   
 }
  
}



