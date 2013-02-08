// creates horse objects
class Horsie {
  float w; // width of the horse
  float h; // height of the horse
  float xPos; // horizontal position
  float yPos; // vertical position
  int position; // lane placement
  int number; // ID number of the horse
  color horsieColor; // color of the horse
  PFont fontNum; // font for displaying the horse number

  Horsie(int num, color c, float horsieHeight, int position) { // horsie accepts a color, height and lane position
    this.position=position;
    this.w=horsieHeight; // horse width and height are the same
    this.h=horsieHeight; 
    this.xPos=w/2; // places horse at the starting position
    this.yPos=(position*h)+h/2; // places horse in it's proper lane
    this.horsieColor=c;
    this.number=num;
  }


  // show the horse in it's proper place
  void display() {

      fontNum = font;

    // draw a horse
    PImage img;
    PImage maskImg;
    img = loadImage("rocking-horse.jpg");
    maskImg = loadImage("rocking-horse-mask.jpg");
    tint(horsieColor);
    imageMode(CENTER); // center the horse
    img.mask(maskImg); // mask the horse outline
    image(img, xPos, yPos, 300/4, 225/4); // draw the horse image
    ellipseMode(CENTER); // draw the number background from the center
    strokeWeight(1);
    stroke(0);
    fill(255);
    yPos=(position*h)+h/2; // places horse in it's proper lane
    ellipse(xPos,yPos-h/10,w/3.25,h/3.25);
    textFont(fontNum, 14);
    fill(0);
    textAlign(CENTER);
    text(number, xPos+1, yPos); // draw the horse number
  }


  // advance the horse position
  void move(int step) { // move accepts a step argument for move distance
    xPos+=step; // advance the horse by the step amount
    if(xPos-w>width) {
      xPos=-w; // don't let the horse go offscreen
    }
  }
}

