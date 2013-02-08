//class myIOIOThread extends Thread {
//
//  boolean running;
//  String id;
//  int wait;
//  DigitalOutput led;
//  AnalogInput in1;
//  AnalogInput in2;
//  AnalogInput in3;
//  int count;
//  int ledpin = 3; //pin for our led
//  
//  int sensor1 = 33;
//  int sensor2 = 34;
//  int sensor3 = 35;
//  
//  
//  float value1; //our analog values range from 0 to 1
//
//
//  myIOIOThread(String s, int w) {
//
//    id = s;
//    wait = w;
//    running = false;
//    count = 0;
//    
//  }
//
//
//  void start() {
//    running = true;
//
//    try {
//      IOIOConnect();
//    } 
//    catch (ConnectionLostException e) {
//    }
//
//
//    try {
//      
//      led = ioio.openDigitalOutput(ledpin);
//      in1 = ioio.openAnalogInput(sensor1);
//      in2 = ioio.openAnalogInput(sensor2);
//      in3 = ioio.openAnalogInput(sensor3);
//    } 
//    catch (ConnectionLostException e) {
//    }
//
//
//    super.start();
//  }
//
//  void run() {
//    
//    while (running) {
//      //count++;
//      try {
//        led.write(lightOn);
//        value1 = in1.read();
//      } 
//      catch (ConnectionLostException e) {
//      }
//      catch (InterruptedException e) {
//      }
//
//      try {
//        sleep((long)(wait));
//      } 
//      catch (Exception e) {
//      }
//    }
//  }
//
//  void quit() {
//    running = false;
//    //led.close();
//    ioio.disconnect();
//    interrupt();
//  }
//
//
//
//  void IOIOConnect() throws ConnectionLostException {
//
//    try {
//      ioio.waitForConnect();
//    }
//    catch (IncompatibilityException e) {
//    }
//  }
//}

