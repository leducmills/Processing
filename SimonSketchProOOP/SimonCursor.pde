class SimonCursor {
 
 float x;
 float y;
 float siz;
 float light;
// int stroke;
// int fill;
 
 SimonCursor (float _x, float _y, float _siz, float _light) {
  
  x = _x;
  y = _y;
  siz = _siz;
  light = _light;
   
 }
  
  
  void render() {
    ellipse(x,y,siz,siz);
  }
  
//  void fill(int fill) {
//    fill(fill);
//  }
//  
//  void stroke(int stroke) {
//   stroke(stroke); 
//  }
  
  
 
 void changeColor(int colorC) {
  //match the color to the button press
  switch (colorC) {
  case 2: //yellow
    stroke(255, 255, 0, light);
    fill(255, 255, 0, light);
    break;
  case 6: //red
    stroke(255, 0, 0, light);
    fill(255, 0, 0, light);
    break;
  case 9: //green
    stroke(0, 255, 0, light);
    fill(0, 255, 0, light);
    break;
  case 12: //blue
    stroke(0, 0, 255, light);
    fill(0, 0, 255, light);
    break;
  default:
    stroke(0, 0, 255, light);
  }
}
  
}
