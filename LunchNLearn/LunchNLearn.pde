//Part 1:
//ellipse(50,50,80,80);


//Part 2:
void setup() {
  
  size(480, 240);
  smooth();
}

void draw() {
  //background(0);
  if (mousePressed) {
    fill(0);
  } else {
    fill(255);
  }
  ellipse(mouseX, mouseY, 80, 80);
}


//Part 3:
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
