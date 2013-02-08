import processing.serial.*;

Serial myPort;  // The serial port

void setup() {
  // List all the available serial ports
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
}

void draw() {
  while (myPort.available () > 0) {



    String myString = myPort.readStringUntil('\n');

    if (myString != null) {

      myString = trim(myString);
      //print(myString);

      for (int i = 0; i < myString.length(); i++) {
        
        println(i + " " + myString.charAt(i));
        
      }
    }

    //      for(int i = 0; i < inBuffer.length; i++) {
    //        
    //      }

    //      String string2 = str(inBuffer[0]);
    //      println(string2);
  }
}

