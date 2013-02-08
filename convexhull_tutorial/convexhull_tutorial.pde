import quickhull3d.*;

QuickHull3D hull = new QuickHull3D();
Point3d[] points;



void setup() {
  size(400, 400, P3D);  
}


void draw() {
  background(255);
  translate(width/2, height/2 -50, 200);
  lights();
  rotateY(frameCount * 0.01);  
 
Point3d[] points = new Point3d[] { 
                new Point3d (0.0,  0.0,  0.0),
                new Point3d (0.0,  0.0,  10.0),
                new Point3d (0.0,  10.0,  10.0),
                new Point3d (0.0,  10.0,  0.0),
                new Point3d (10.0,  0.0,  0.0),
                new Point3d (10.0,  0.0,  10.0),
                new Point3d (10.0,  10.0,  10.0),
                new Point3d (10.0,  10.0,  0.0),
                new Point3d (5.0, 5.0, 5.0),

	      };

	   
	   hull.build (points);
           //print(points.length);        

  
  Point3d[] vertices = hull.getVertices();
//	   for (int i=0; i<vertices.length; i++)
//	    { Point3d pnt = vertices[i];
//	      //println (pnt.x + " " + pnt.y + " " + pnt.z);
//              float x = (float)pnt.x;
//              float y = (float)pnt.y;
//              float z = (float)pnt.z;
//              vertex(x,y,z);            
//	    }
  beginShape();  
   println ("Faces:");
   int[][] faceIndices = hull.getFaces();
   //print(faceIndices.length);
   for (int i = 0; i < faceIndices.length; i++) {  
     for (int k = 0; k < faceIndices[i].length; k++) {
       
        //print (faceIndices[i][k] + " ");
        
        Point3d pnt2 = vertices[faceIndices[i][k]];
        print(pnt2);
        float x = (float)pnt2.x;
        float y = (float)pnt2.y;
        float z = (float)pnt2.z;
        vertex(x,y,z);
       }
      println ("");
    }


endShape();

}


