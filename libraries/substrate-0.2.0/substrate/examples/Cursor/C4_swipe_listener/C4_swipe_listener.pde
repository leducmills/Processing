/**
 * (c)  oblong industries, inc.  2012
 *
 * Create a custom cursor object for each connected device
 * that listenes to that device's events. Listens for harden,
 * soften, and swipe events.
 */

import com.oblong.gspeak.*;

// the object that will give us access to data from g-speak.
Substrate substrate;
ArrayList<CustomCursor> cursors;
void setup () {
  size (800, 800);
  smooth ();
  // connect to g-speak server
  substrate = new Substrate (this);
  colorMode( HSB, 1.0 );
  cursors = new ArrayList<CustomCursor>();
}

void draw ()
{
  background (0);
  for ( CustomCursor c : cursors )
  {
    c.draw();
  }
}

void pointerAppeared(Pointer p)
{
  cursors.add( new CustomCursor(p) );
}

// our representation of a cursor
// declared 'public' so pointers can call its methods
public class CustomCursor
{
  float x, y;
  float diameter;
  float h, s, b;
  CustomCursor( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    diameter = 40;
    h = random(1.0f);
    s = 1.0;
    b = 1.0;
  }

  void draw()
  {
    fill( color( h, s, b ) );
    ellipse( x, y, diameter, diameter );
  }

  // a pointer event handler
  void pointerMoved( Pointer p )
  {
    x = p.x();
    y = p.y();
  }

  void pointerHardened( Pointer p )
  {
    diameter = 30;
    b = 0.8;
  }

  void pointerSoftened( Pointer p )
  {
    diameter = 40;
    b = 1.0;
  }
  
  void pointerSwipedRight( Pointer p )
  {
    h += 0.075f;
    h %= 1.0f;   
  }
  
  void pointerSwipedLeft( Pointer p )
  {
    h -= 0.075f;
    h %= 1.0f;
  }
}

