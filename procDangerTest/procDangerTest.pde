import processing.serial.*;

PImage img01;
PImage img02;
PImage img03;
int backgnd;

Serial usbPort;
int[] sensors = null;
boolean firstContact = false;


void setup() {
  size(700, 500);
  img01 = loadImage("seer2.png"); //filename is case sensitive
  img02 = loadImage("seer1.png");
  img03 = loadImage("seer3.png");
  usbPort = new Serial (this, Serial.list( )[0], 9600);
  usbPort.bufferUntil('\n');
}

void draw() {
//  backgnd = 3; 
//  simpleImage(backgnd);
}

void SerialEvent (Serial usbPort) {

  String usbString = usbPort.readStringUntil('\n');
  if (usbString != null) {
    usbString = trim(usbString);

    if (firstContact == false) {
      if (usbString.equals("Hello")) {
        usbPort.clear();
        firstContact = true;
        usbPort.write('A');
        println("contact");
      }
    }

    else {
      int sensor[] = int(split(usbString, ","));
      for (int sensorNum = 0; sensorNum < sensor.length; sensorNum++) {
        println(sensorNum + " " + sensor[sensorNum]);
      }
      
      usbPort.write("A");
      
    }
  }
}

