import processing.serial.*;

Serial myPort;
String right = "G1" + " " + "X+0.25" + "\n";
String left = "G1" + " " + "X-0.25" + "\n";
String up = "G1" + " " + "Y-0.25" + "\n";
String down = "G1" + " " + "Y+0.25" + "\n";
String penUp = "G1" + " " + "Z-0.25" + "\n";
String penDown = "G1" + " " + "Z+0.25" + "\n";
String upRight = "G1" + " " + "X+0.25 Y-0.25" + "\n";
String upLeft = "G1" + " " + "X-0.25 Y-0.25" + "\n";
String downRight = "G1" + " " + "X+0.25 Y+0.25" + "\n";
String downLeft = "G1" + " " + "X-0.25 Y+0.25" + "\n";



float xPos;
float yPos;

long lastKey = 0;
long keyDelay = 200;

void setup() {

  size(1000, 500);
  background(100);
  xPos = width/2;
  yPos = height/2;
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 19200);
}

void draw() {
  fill(0);
  noStroke();
  ellipse(xPos, yPos, 5, 5);
}
void mousePressed() {

  fill(0);
}


void keyPressed() {

  if (millis() - lastKey < keyDelay) {
    return;
  }
  else {
    lastKey = millis();
  }

  if (key == CODED) {
    if (keyCode == RIGHT) {
      myPort.write(right);
      xPos+=2;
      print(right);
      //delay(1000);
    }
    else if (keyCode == LEFT) {
      myPort.write(left);
      xPos-=2;
      print(left);
      //delay(1000);
    }
    else if (keyCode == UP) {
      myPort.write(up);
      yPos-=2;
      print(up);
      //delay(1000);
    }
    else if (keyCode == DOWN) {
      myPort.write(down);
      yPos+=2;
      print(down);
      //delay(1000);
    }
    /*else if (keyCode == UP && keyCode == RIGHT) {
     myPort.write(upRight);
     yPos-=2;
     xPos+=2;
     print(upRight);
     }  */
  }
  else if (key == ' ') {
    myPort.write(penUp);
    print(penUp);
  }
  else if (key == ENTER | key == RETURN) {
    myPort.write(penDown);
    print(penDown);
  }
  else if (key == TAB) {
    yPos = 250;
    xPos = 500;
    background(100);
  }
  else if (key == '4') {
    myPort.write(left);
    xPos-=2;
  }
  else if (key == '6') {
    myPort.write(right);
    xPos+=2;
  }
  else if (key == '2') {
    myPort.write(down);
    yPos+=2;
  }
  else if (key == '8') {
    myPort.write(up);
    yPos-=2;
  }
  else if (key == '7') {
    myPort.write(upLeft);
    yPos-=2;
    xPos-=2;
  }
  else if (key == '9') {
    myPort.write(upRight);
    yPos-=2;
    xPos+=2;
  }
  else if (key == '3') {
    myPort.write(downRight);
    yPos+=2;
    xPos+=2;
  }
  else if (key == '1') {
    myPort.write(downLeft);
    yPos+=2;
    xPos-=2;
  }
  else if (key == '5') {
    myPort.write(penUp);
    fill(100);
  }
  else if (key == '0') {
    myPort.write(penDown);
    fill(0);
  }
}

