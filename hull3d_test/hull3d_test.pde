float [][][] points = new float[10][2][2];

void setup() {
 
 size(400,400,P3D);
 
 initPoints();
 //print(points.length);
 background(255);

  
}

void draw() {
  
  background(255);
  translate(width/2, height/2, -1000);
   
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
  
  points[i][0][0] = (int)random(300);
  points[i][0][1] = (int)random(300);
  points[i][1][0] = (int)random(300);
  
  //println(points[i][0][0] + "," + points[i][1][0] + "," + points[i][0][1]);
  
  println(points.length);
 
  
   
 }
 
  
}
