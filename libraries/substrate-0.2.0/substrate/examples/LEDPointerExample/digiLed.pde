/*
this class supplies an onscreen "led" whose behavior
 is mirrored in a physical led connected to your
 arduino
 ...or maybe the onscreen led mirrors the physical led!??!?!
 */

public class DigiLed
{
  float x, y, r;
  boolean on;
  int pin;

  DigiLed( float ix, float iy, float ir, int ip)
  {
    x = ix;
    y = iy;
    r = ir;
    on = false;
    setPin(ip);
  }

  void setPin(int n)
  {
    pin = n;
//    arduino.pinMode(n, Arduino.OUTPUT);  //for arduino, uncomment this
  }

  void setOnOrOff(boolean b)
  {
    if (b)
      on = true;
    else if (!b)
      on = false;
  }

  void draw()
  {
    if (on)
    {
      fill(237, 135, 0);
      noStroke();
      ellipse(x, y, r, r);
//      arduino.digitalWrite (pin, Arduino.HIGH);  //for arduino, uncomment this
    }
    else if (!on)
    {
      fill(118, 67, 0);
      noStroke();
      ellipse(x, y, r, r);
//      arduino.digitalWrite (pin, Arduino.LOW);  //for arduino, uncomment this
    }
  }
}

