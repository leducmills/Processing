import processing.serial.*;

Serial usbPort;

int[] sensorData;

void setup() {

  usbPort = new Serial(this, Serial.list()[0], 9600);
  usbPort.bufferUntil('\n');
}

void draw() {
}

void serialEvent( Serial usbPort) {

  String usbString = usbPort.readStringUntil('\n');

  if(usbString != null) {

    usbString = trim(usbString);
    //println(usbString);

    int sensors[] = int(split(usbString, ','));
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      //println(sensors.length);
    }
  }
}
