void setup(){
  size(600,300);
  grid(100);
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
