import processing.serial.*;

Serial myPort;

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  // myPort.bufferUntil('\n');
  size(600,600);
}

void draw() {
}

void serialEvent(Serial myPort) {
  background(255); 

  int in = myPort.read();
  fill(0);
  ellipse(in, in, in, in);

  println(in);
}

