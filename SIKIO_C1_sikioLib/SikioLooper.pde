DigitalOutput redLed, greenLed, blueLed;

//Here are the pins on the IOIO board we want to use.
int redPin = 3;
int greenPin = 2;
int bluePin = 1;

void ioioSetup(IOIO ioio) throws ConnectionLostException {
  //led = ioio.openDigitalOutput(IOIO.LED_PIN, true);
  redLed = ioio.openDigitalOutput(redPin);
  greenLed = ioio.openDigitalOutput(greenPin);
  blueLed = ioio.openDigitalOutput(bluePin);
}

void ioioLoop(IOIO ioio) throws ConnectionLostException {
  //led.write(false); // status LED is active LOW
  try {
    redLed.write(redOn);
    greenLed.write(greenOn);
    blueLed.write(blueOn);
    Thread.sleep(100);
  }
  catch (InterruptedException e) {
  }
}

