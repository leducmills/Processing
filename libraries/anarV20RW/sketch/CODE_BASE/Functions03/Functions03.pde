void setup(){
  size(600,300);
  grid(myDouble(50));
}

void grid(int gridSize) {  
  // horizontal grid lines
  for (int a=0; a<height; a=a+gridSize){
    line(0, a,  width, a); 
  }  

  // vertical grid lines
  for (int a=0; a<width; a=a+gridSize){
      line(a, 0,  a, height); 
  }  
}

int myDouble(int a) {
   return 2*a;
}
