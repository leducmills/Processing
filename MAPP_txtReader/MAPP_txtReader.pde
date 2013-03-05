import processing.serial.*;

/* Reads from a .txt file of GCode commands and sends them out the Serial port */


String[] commands;
int index = 0;

Serial port;

long lastComm = 0;
long commDelay = 500;

void setup() {
  size(300, 300);
  background(0);
  stroke(0, 230, 0);
  frameRate(12);
  commands = loadStrings("/Users/Ben/Desktop/GCodeTest.txt");
  port = new Serial(this, Serial.list()[4], 19200);
}


void draw() {

  if (millis() - lastComm < commDelay) {
    return;
  }
  else {
    lastComm = millis();
  }


  if (index < commands.length) {
    
    if (commands[index].contains("G1")) {
      println(commands[index]);
      port.write(commands[index]);
    }
    index++;
  }
}

