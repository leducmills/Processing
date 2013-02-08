void setup(){
  size(600,300);
}


void draw(){

  if( (frameCount%10) == 0)
    background(255,0,0);
  else
    background(155);

  println(frameCount);
}

