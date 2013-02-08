class IOIOThread extends Thread {

  boolean running; //is our thread running?
  String id; 
  int wait;  //how often we want our thread to run
  DigitalInput button; //our button is a DigitalInput
  AnalogInput pot; //our potentiometer is an AnalogInput
  int count;
  int buttonPin = 4; //pin for our button
  int potPin = 40; // pin for our potentiometer
  float potVal; //our analog values range from 0 to 1
  boolean buttonVal; //digital in is either 0 OR 1 (true or false)


  IOIOThread(String s, int w) {

    id = s;
    wait = w;
    running = false;
    count = 0;
  }


  void start() {
    running = true;

    try {
      //connect to the IOIO
      IOIOConnect();
    } 
    catch (ConnectionLostException e) {
    }


    try {
      
      //try opening our input pins
      button = ioio.openDigitalInput(buttonPin);
      pot = ioio.openAnalogInput(potPin);
    } 
    catch (ConnectionLostException e) {
    }

    //don't forget this!
    super.start();
  }

  void run() {

    while (running) {

      try {
        //while we're running, read our potentiometer and button values
        potVal = pot.read();
        buttonVal = button.read();
      } 
      catch (ConnectionLostException e) {
      }
      catch (InterruptedException e) {
      }

      try {
        sleep((long)(wait));
      } 
      catch (Exception e) {
      }
    }
  }

  void quit() {
    running = false;
    //led.close();
    ioio.disconnect();
    interrupt();
  }



  void IOIOConnect() throws ConnectionLostException {

    try {
      ioio.waitForConnect();
    }
    catch (IncompatibilityException e) {
    }
  }
}

