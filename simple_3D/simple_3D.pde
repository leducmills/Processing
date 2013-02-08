import processing.opengl.*;

import processing.serial.*;

boolean firstContact = false;
Serial usbPort;
int[] sensorData;

int slider1;
int slider2;
int slider3;

void setup() {

  usbPort = new Serial(this, Serial.list()[0], 9600);
  usbPort.bufferUntil('\n');
  size(600, 600);
  background(255);
  smooth();
  //size(600, 600, OPENGL);
}


void draw() {
  background(255);  
  translate(58, 48, 0); 
  //rotateY(mouseY);
  //rotateX(mouseX);
  //box(slider1, slider2, slider3);
  
}

void serialEvent (Serial usbPort) {

  String usbString = usbPort.readStringUntil('\n');
  if (usbString != null) {

    usbString = trim(usbString);
    if (firstContact == false) {
      if (usbString.equals("Hello")) {
        usbPort.clear();
        firstContact = true;
        usbPort.write('A');
        println("we are communicating!");
      }
    }

    else {
      
      println(usbString);

       

      int sensors[] = int(split(usbString, ','));

      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      }

//      if (sensors.length > 2) {
//        slider1 = sensors[0];
//        slider2 = sensors[2];
//        slider3 = sensors[4];
//      }

      //      button1 = sensors[1];
      //      button2 = sensors[3];
      //      button3 = sensors[5];


      //slider1 = int(map(slider1, 1, 1023, 1, 3));


      //usbPort.write("A");
    }
  }
}

