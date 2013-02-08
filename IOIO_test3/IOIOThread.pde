class myIOIOThread extends Thread {

  boolean running;
  String id;
  int wait;
  DigitalOutput led;
  int count;
  int pin = 3;


  myIOIOThread(String s, int w) {

    id = s;
    wait = w;
    running = false;
    count = 0;
    
  }


  void start() {
    running = true;

    try {
      IOIOConnect();
    } 
    catch (ConnectionLostException e) {
    }


    try {
      led = ioio.openDigitalOutput(pin);
    } 
    catch (ConnectionLostException e) {
    }


    super.start();
  }

  void run() {
    
//   try {
//      led = ioio.openDigitalOutput(3);
//    } 
//    catch (ConnectionLostException e) {
//    }
    
    while (running) {
      //count++;
      try {
        led.write(lightOn);
      } 
      catch (ConnectionLostException e) {
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

