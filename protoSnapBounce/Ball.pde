
//class for pong balls
class Ball {

  float bSize;
  float xpos, ypos;
  float xspeed, yspeed;
  float xdir, ydir;

  Ball(float ibSize, float ixpos, float iypos, float ixspeed, float iyspeed, float ixdir, float iydir) {

    bSize = ibSize;
    xpos = ixpos;
    ypos = iypos;
    xspeed = ixspeed;
    yspeed = iyspeed;
    xdir = ixdir;
    ydir = iydir;
  }


  void update() {

    xpos = xpos + (xspeed * xdir);
    ypos = ypos + (yspeed * ydir);

    if(ypos > height-bSize || ypos < 0) { //ball hits top or bottom
      ydir *= -1;
    }
    if(xpos > width-bSize || xpos < 0) { 
      xdir *= -1;
    }
  }
  
  void wobble() {
    ellipse(xpos+bSize/2, ypos+bSize/2, bSize+random(-bSize/4,bSize/4), bSize+random(-bSize/4,bSize/4));
  }

  void display() {
    ellipse(xpos+bSize/2, ypos+bSize/2, bSize, bSize);
  }
  

}

//my e-mail: ben.leduc-mills@sparkfun.com















