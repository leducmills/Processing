size(600,300);

// horizontal grid lines
for (int i=0; i<height; i=i+100){
  line(0, i,  width, i);                       
}  

// vertical grid lines
for (int i=0; i<width; i=i+100){
  line(i, 0,  i, height); 
}
