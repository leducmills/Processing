
//class for pong balls
class Ball {

  float bSize;
  float xpos, ypos;
  float xspeed, yspeed;
  float xdir, ydir;
  float red, green, blue;
  Ball[] others;
  int id;
  float diameter;
  float vx = 0;
  float vy = 0;

  Ball(float ibSize, float ixpos, float iypos, float ixspeed, float iyspeed, float ixdir, float iydir, float ired, float igreen, float iblue, Ball[] oin, int oid, float odiameter) {

    bSize = ibSize;
    xpos = ixpos;
    ypos = iypos;
    xspeed = ixspeed;
    yspeed = iyspeed;
    xdir = ixdir;
    ydir = iydir;
    red = ired;
    green = igreen;
    blue = iblue;
    others = oin;
    id = oid;
    diameter = odiameter;
    
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
    fill(red, green, blue, lightSensor);
    ellipse(xpos+bSize/2, ypos+bSize/2, bSize, bSize);
  }
  
  void collide() {
    for (int i = 1; i < ballID; i++) {
      println(i);
      float dx = others[i].xpos - xpos;
      float dy = others[i].ypos - ypos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = xpos + cos(angle) * minDist;
        float targetY = ypos + sin(angle) * minDist;
        float ax = (targetX - others[i].xpos) * spring;
        float ay = (targetY - others[i].ypos) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  

}

//my e-mail: ben.leduc-mills@sparkfun.com















