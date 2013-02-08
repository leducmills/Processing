class Ball {
 
 float bsize;
 float xpos, ypos;
 float xspeed, yspeed;
 float xdir, ydir;
 
 Ball(float _bsize, float _xpos, float _ypos, float _xspeed, float _yspeed, float _xdir, float _ydir) {
  
   bsize = _bsize;
   xpos = _xpos;
   ypos = _ypos;
   xspeed = _xspeed;
   yspeed = _yspeed;
   xdir = _xdir;
   ydir = _ydir;
   
 }
 
 void update(int slider1, int slider2) {

    //bsize = slider1;
    xpos = xpos + (slider1 * xdir);
    ypos = ypos + (slider2 * ydir);

    if(ypos > height-bsize || ypos < 0) { //ball hits top or bottom
      ydir *= -1;
    }
    if(xpos > width-bsize || xpos < 0) { 
      xdir *= -1;
    }
  }
 
 void wobble() {
    ellipse(xpos+bsize/2, ypos+bsize/2, bsize+random(-bsize/4,bsize/4), bsize+random(-bsize/4,bsize/4));
  }

  void display() {
    ellipse(xpos+bsize/2, ypos+bsize/2, bsize, bsize);
  }
 
 
  
}
