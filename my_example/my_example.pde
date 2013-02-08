PFont myFont; //init font for text

void setup() {
  size(400,400); //sets window size in pixels
  myFont = createFont("FFScala", 32); //create font
  textFont(myFont);
  fill(0);  //set text fill color to black
}

void draw() {
  background(255); //sets background to white
  
  //draws hello world to window with and ellipse and rect
  myDraw();
  

}

void myDraw() {
  
  text("Hello, world!", 50, 100);
  noFill();
  ellipse(30, 30, 35, 35);  //(x,y,width,height)
  rect(100, 110, 100, 100); //(x,y,width,height)
}
