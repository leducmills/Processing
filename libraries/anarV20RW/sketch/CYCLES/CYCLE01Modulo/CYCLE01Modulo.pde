void setup(){
  size(600,300);
}

int count=0;

void draw(){
  
  if(count==10)
    {
      background(255,0,0);
      count = 0;
    }
  else
    background(155);
  
  count = count+1;
  
  println(count);
}

