// creates a finish line object
class FinishLine {
  float xPos;
  
  FinishLine(float x) { // finish line accepts a position argument
    xPos=x;
  }
  void  display() {
    // draw a line at the finish line position
    strokeWeight(2);
    stroke(0);
    line(xPos,0,xPos,height);
  }
}

