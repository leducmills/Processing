void setup(){
  size(600,300);
}


void draw(){

  if( (frameCount%10) == 0)
    background(mouseX,0,0);
  else
    background(mouseY);

  println("Count:" + frameCount + "| mouseX:" + mouseX + " | mouseY:" + mouseY);
}

