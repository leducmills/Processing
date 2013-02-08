import processing.serial.*;


PImage img1;
Serial myPort;
int[] sensors = null;
boolean firstContact = false;
int scaledRed, scaledGreen, scaledBlue;

void setup() {
  size(700, 500);
  img1 = loadImage("welding5.jpg");
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}

void draw() {

  simpleImage(scaledRed, scaledGreen, scaledBlue);
}

void serialEvent (Serial myPort) {

  String usbString = myPort.readStringUntil('\n');
  if (usbString != null) {
    usbString = trim(usbString);

    if (firstContact == false) {
      if (usbString.equals("Hello")) {
        myPort.clear();
        firstContact = true;
        myPort.write('A');
        println("contact");
      }
    }
    else {

      int sensors[] = int(split(usbString, ','));

      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      }

      int slider1 = sensors[0];
      //int button1 = sensors[1];
      int slider2 = sensors[2];
      //int button2 = sensors[3];
      int slider3 = sensors[4];
      //int button3 = sensors[5];

      scaledRed = int(map(slider1, 0, 1023, 0, 255));
      scaledGreen = int(map(slider2, 0, 1023, 0, 255));
      scaledBlue = int(map(slider3, 0, 1023, 0, 255));
    }
  }
}

