
/* MLX90620 InfraRed Temp Sensor Array */

import processing.serial.*;

Serial port; //the Serial port we're using

//int SerialCount = 0; //number of values in
//boolean firstContact = false; //have we heard from the Arduino?
TempBox[] boxes = new TempBox[64];
float[] values = new float[64];

void setup() {

  size(1200, 300);
  background(255);
  noStroke();
  colorMode(HSB, 255);

  println(Serial.list());

  //you may have to change the [4] to match the port in the array that you're using
  String portName = Serial.list()[4];
  port = new Serial(this, portName, 9600);
  initArray();
  //  fakeSerial();
}


void draw() {

  for (int i = 0; i < boxes.length; i++) {
    boxes[i].update(values[i]);
    boxes[i].display();
  }
}


void serialEvent( Serial port) {

  String data = port.readStringUntil('*');

  if (data != null) {

    values = float(splitTokens(data, "$ , *"));

    for (int i = 0; i < values.length; i++) {
      println(i + " " + values[i]);
    }
  }
}


void initArray() {

  int xpos = 5;
  int ypos = 5;
  int counter = 0; 

  for (int i = 0; i < 4; i ++) {

    for (int j = 0; j < 16; j++) {

      boxes[counter] = new TempBox(xpos, ypos, 0);

      xpos += 75;
      counter++;
    }
    xpos = 5;
    ypos += 75;
  }
}

