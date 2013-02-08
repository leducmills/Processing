
int xpos;
int ypos;
int zpos;

String inString = "10,10,10;20,20,20;";



void setup() {
 
 size(400,300, P3D);
 
 
  
}


void draw() {
 
 background(255); 
 translate(width/2, height/2, -100);
 rotateY(frameCount * 0.01);
 
 String coord[] = split(inString, ';');
 
 
 
 
 
 for( int i = 0; i < coord.length -1; i++ ) {
    
    int subCoord[] = int(split(coord[i], ','));
    point(subCoord[0], subCoord[1], subCoord[2]);
    
    println(subCoord[2]);
   
 }
}
 
 
 
