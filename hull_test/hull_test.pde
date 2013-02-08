import megamu.mesh.*;


float[][][] points = new float[3][2][2];
Hull myHull;
MPolygon myRegion;

void setup() {
 
 size(200,200, P3D); 
  
 for (int i = 0; i < points.length; i++) {
    points[i][0][0] = random(50);
    points[i][0][1] = random(50);
    points[i][1][0] = random(50);
    points[i][1][1] = random(50);
     
 }
 
 myHull = new Hull(points);
  
}


void draw() {
  
  myRegion = myHull.getRegion();
  fill(0);
  myRegion.draw(this);
  
}
