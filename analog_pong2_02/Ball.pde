
//class for pong balls
class Ball {

  int bSize;
  float xpos, ypos;
  float xspeed, yspeed;
  float xdir, ydir;

  Ball(int ibSize, float ixpos, float iypos, float ixspeed, float iyspeed, float ixdir, float iydir) {

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

    //if hits paddle, change direction
    if ((xpos > rightPaddle.xPos - bSize && xpos < width - bSize && 
      ypos < rpp + rightPaddle.pHeight/2 - bSize && 
      ypos > rpp - rightPaddle.pHeight/2 - bSize) || 
      (xpos < leftPaddle.xPos + bSize && xpos < 0 + bSize &&
      ypos < lpp + leftPaddle.pHeight/2 - bSize &&
      ypos > lpp - leftPaddle.pHeight/2 - bSize) )

    {
      xdir *= -1;  //change ball direction
    }

    if (xpos > width-bSize) { //player one scored
      playerOne++;
      if (playerOne < 7) {
        //println(playerOne);
        reset();
      }
      else if (playerOne == 7) {
        oneWins = true;
        xpos = width/2;
        ypos = height/2;
        xdir = 0;
        ydir = 0;
      }
    }


    if(xpos < 0) { //player two scored

      playerTwo++;

      if(playerTwo < 7) {
        //println(playerTwo);
        reset();
      }
      else if (playerTwo == 7) {
        twoWins = true;
        xpos = width/2;
        ypos = height/2;
        xdir = 0;
        ydir = 0;
      }
    }



    if(ypos > height-bSize || ypos < 0) { //ball hits top or bottom
      ydir *= -1;
    }
  }

  void display() {
    ellipse(xpos+bSize/2, ypos+bSize/2, bSize, bSize);
  }

  void reset() {
    xpos = width/2;
    ypos = height/2;
    ydir = random(-1, 1);
    float dir = random(-1, 1);
    if (dir > 0) {
      xdir = 1;
    }
    else if (dir <= 0) {
      xdir = -1;
    }
  }

  void keyPressed() {

    if(keyCode=='R') {
      newGame();
    }

    if(keyCode=='1') {
      bSize++;
    }
    if(keyCode=='2') {
      bSize--;
    }
    if(keyCode=='3') {
      leftPaddle.pHeight++;
    }    
    if(keyCode=='4') {
      leftPaddle.pHeight--;
    }
    if(keyCode=='5') {
      rightPaddle.pHeight++;
    }    
     if(keyCode=='6') {
      rightPaddle.pHeight--;
    }
  }


  void newGame() {

    playerOne = 0;
    playerTwo = 0;
    oneWins = false;
    twoWins = false;
    reset();
  }
}

