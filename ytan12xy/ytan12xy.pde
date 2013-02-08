float y = 0;
float x = 0;

void setup() {
  background(255);
  size(640,480);
  stroke(0);  
}


void draw() {
  
  for(int i = 0; i < 1000000; i++) {
   // y=tan12x^y
//   y = tan(12 * x);
//   y = pow(y, y);

   //x = pow(x,2);
   
   point(x, pow(tan(12* x),y));
   
   //point(x,pow(y,2)); 
   //println(x + " " + y); 
   //x++;
   y+= 0.01;
   x+= 0.01;
   
   
  }
  
  noLoop();
  
}
