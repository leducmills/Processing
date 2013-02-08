import megamu.mesh.*;


float[][] points = new float[10][3];
Hull myHull;
MPolygon myRegion;

void setup() {
 
 size(400,400); 
  
 for (int i = 0; i < points.length; i++) {
    points[i][0] = random(350);
    points[i][1] = random(350);
    println(points[i][0] + "," + points[i][1]); 
 }
 
 myHull = new Hull(points);
  
}


void draw() {
  
  myRegion = myHull.getRegion();
  fill(0);
  myRegion.draw(this);
  
}
