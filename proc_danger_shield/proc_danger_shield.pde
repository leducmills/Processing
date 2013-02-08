import processing.serial.*;

PImage img01;
PImage img02;
PImage img03;
boolean firstContact = false;
Serial usbPort;
int[] sensorData;
int slider1 = 100;
int slider2;
int slider3;

int button1;
int button2;
int button3;

int x = 10;
int y = 10;

Ball myball;

void setup() {

  usbPort = new Serial(this, Serial.list()[0], 9600);
  usbPort.bufferUntil('\n');
  myball = new Ball(20, 10, 10, 20, 20, 1, 1); 
  //myball = null;
  //size(500, 700, P3D);
  size(600, 500);
  img01 = loadImage("welding1.jpg");
  img02 = loadImage("welding2.jpg");
  img03 = loadImage("welding3.jpg");
}

void draw() {  
  background(255);
  stroke(0);
  fill(0);
  //myball = new Ball(slider1, 10, slider2, slider3, 20, 1, 1);
  //translate(100,100,0);
  //simpleImage(200, 100, 10, 100);
  //simpleImage(slider1);
  //  simpleImage(slider1, slider2, slider3);
  //  buttonSizer(button1, button2, button3);
  //boxer(slider1, slider2, slider3);
//  if (myball == null) {
//    myball = new Ball(slider1, 10, 10, 20, 20, 1, 1);
//  }
//println(slider1);

  myball.update(slider1, slider2);
  myball.display();
  myball.wobble();
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

      int sensors[] = int(split(usbString, ','));

      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        println("Sensor " + sensorNum + ": " + sensors[sensorNum]);
      }

      slider1 = sensors[0];
      slider2 = sensors[2];
      slider3 = sensors[4];

      button1 = sensors[1];
      button2 = sensors[3];
      button3 = sensors[5];

//      slider1 = int(map(slider1, 0, 1023, 1, 50));
//      slider2 = int(map(slider2, 0, 1023, 1, 50));
//      slider3 = int(map(slider3, 0, 1023, 1, 50));


      //slider1 = int(map(slider1, 1, 1023, 1, 3));


      //usbPort.write("A");
    }
  }
}







