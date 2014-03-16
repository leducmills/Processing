/* 
 SparkFun SIKIO - Circuit 3
 CC BY-SA, http://creativecommons.org/licenses/by-sa/3.0/
 */

//Define your IOIO variables here.
PwmOutput piezo; //Piezo buzzers are pulse-modulated output
int piezoPin = 11; // pin for our potentiometer
//int freq = 523; //our beginning frequency

void ioioSetup(IOIO ioio) throws ConnectionLostException 
{
  // Open and close the piezo pin just to give us a connection and set the duty cycle
  piezo = ioio.openPwmOutput(piezoPin, freq); 
  piezo.setDutyCycle(.5);
  piezo.close(); // To stop from the piezo from making sound on startup
}

void ioioLoop(IOIO ioio) throws ConnectionLostException
{
  ioio_good = true;

  if (playTone == true) {
    try 
    {
      piezo = ioio.openPwmOutput(piezoPin, freq);
      piezo.setDutyCycle(.5);
    } 
    catch (ConnectionLostException e) 
    {
    }

    try 
    {
      Thread.sleep(100); //??? here or in ioioloop ???
    } 
    catch (InterruptedException e) 
    {
    }
    piezo.close();
    playTone = false;
  }
}

