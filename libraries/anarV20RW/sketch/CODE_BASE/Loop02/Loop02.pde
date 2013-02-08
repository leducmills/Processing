size(600,300);
int sizeOfGrid = 100;

// horizontal grid lines
for (int i=0; i<height; i=i+sizeOfGrid){
  line(0, i,  width, i); 
}  

// vertical grid lines
for (int i=0; i<width; i=i+sizeOfGrid){
  line(i, 0,  i, height); 
}  
