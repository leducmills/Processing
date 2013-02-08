import unlekker.util.*;
import unlekker.geom.*;
import unlekker.data.*;
import ec.util.*;
import quickhull3d.*;
import processing.serial.*;


int gridSize = 4; //size of grid (assumes all dimensions are equal)
int spacing = 20; //distance between points 


void setup() {
  
  size(800, 600, P3D);  //defines size of canvas and 3d mode
  background(255);  //set initial background color (just looks nicer on startup)

  
}


void draw() {
  
  translate(width/2, height/2 -35, 350); //put grid in center at a good distance
  int xpos = 0;
  int ypos = 0;
  int zpos = 0;
  
  background(255);  
 
  rotateY(frameCount * 0.01);  //rotation
  
  //draw 'active' point(s)
  strokeWeight(5);
  point(1 * spacing, 0 * spacing, 1 * spacing); 
 
 //draw rest of grid
  beginShape(); 
  for (int i = 0; i < gridSize; i++) {
     for (int j = 0; j < gridSize; j++) {
       for( int k = 0; k < gridSize; k++) {
             strokeWeight(2);  
             point(xpos, ypos, zpos);
             xpos += spacing;
           }
       xpos = 0;
       ypos += spacing;   
         }
     xpos = 0;
     ypos = 0;
     zpos += spacing; 
     }
  endShape();     
}

//if any key is pressed, output the STL file
void keyPressed() {
  outputSTL();
}

//function to output STL file
void outputSTL() {
  
  //make sure we have at least 4 points
  //(can't have a 3d shape with less)
  if (points.length > 3) {
    
    //compute the convex hull
    hull.build(points);

    //get an array of the vertices so we can get the faces  
    Point3d[] vertices = hull.getVertices();
  
    //start writing the stl file - file should appear in your sketch folder
    stl=(STL)beginRaw("unlekker.data.STL","convexhull.stl");  
  
    //different beginShape() modes may affect the shape produced 
    beginShape(QUADS);  
    //println ("Faces:");
    int[][] faceIndices = hull.getFaces();
    for (int i = 0; i < faceIndices.length; i++) {  
      for (int k = 0; k < faceIndices[i].length; k++) {
        
        //get points that correspond to each face
        Point3d pnt2 = vertices[faceIndices[i][k]];
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
      }
    }
    
    endShape(CLOSE);
    endRaw();
  }
}
