size(600,300);
int sizeOfGrid = 100;

// horizontal grid lines
for (int i=0; i<height; i=i+sizeOfGrid){
  if (i == 2*sizeOfGrid) {
    line(0, i,  width, i);
  }
  else {
    line(0, i,  width/2, i);
  }  
}  

// vertical grid lines
for (int i=0; i<width; i=i+sizeOfGrid){
  if (i != 3*sizeOfGrid) {
    line(i, 0,  i, height);
  }
  else {
    line(i, 0,  i, height/2);
  } 
}  
