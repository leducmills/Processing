void setup(){
  size(600,300);
  grid();
}

void grid() {        // here the round brackets are needed
  int gridSize = 100;

  // horizontal grid lines
  for (int a=0; a<height; a=a+gridSize){
    line(0, a,  width, a); 
  }  

  // vertical grid lines
  for (int a=0; a<width; a=a+gridSize){
    line(a, 0,  a, height); 
  }  
}
