public class LedPointer
{
  float x, y;
  int swiped;

  LedPointer( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    swiped = 0;
  }

  void draw()
  {
    fill(255);
    stroke(0);
    ellipse( x, y, 20, 20 );
  }

  // a pointer event handler
  void pointerMoved( Pointer p )
  {
    swiped = 0;
    x = p.x();
    y = p.y();
  }
  
  //this method determines which led the pointer wishes to be on
  //you can write other methods with different criteria 
  void turnOnClosestLed(DigiLed[] leds)
  {
    float shortestDistance = width;
    int closestLedIndex = 0;
    for ( int i = 0; i < digiLeds.length; i++)
    {
      if ( dist( x, y, digiLeds[i].x, digiLeds[i].y ) < shortestDistance )
      {
        shortestDistance = dist( x, y, digiLeds[i].x, digiLeds[i].y );
        closestLedIndex = i;
      }
    }
    digiLeds[closestLedIndex].setOnOrOff(true);
  }
}

