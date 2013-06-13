import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

void setup() 
{
  //size(200, 200); //size in pixels of our canvas
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  
  println(val);
  
}
