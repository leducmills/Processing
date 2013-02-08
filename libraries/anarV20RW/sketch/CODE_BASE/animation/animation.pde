void setup(){
  size(600,300);
}

int count=0;

void draw(){
  background(255,0,0);
  count = count+1;
  grid(count);
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
