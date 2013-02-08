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
  while (myPort.available() > 0) {
    int lf = 10;
    //Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[10];
    String[] bytes = new String[10];
    myPort.readBytesUntil(lf, inBuffer);
    
    for(int i = 0; i < inBuffer.length; i++) {
     bytes[i] = str(inBuffer[i]); 
     println(bytes[i]);
    }
    
    if (inBuffer != null) {
      String myString = new String(inBuffer);
      myString = trim(myString);
      //print(myString);
      
//      for(int i = 0; i < inBuffer.length; i++) {
//        
//      }
      
//      String string2 = str(inBuffer[0]);
//      println(string2);

    }
  }
}
