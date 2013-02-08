/**
 * (c)  oblong industries, inc.  2012
 *
 * Create a custom cursor object for each connected device
 * that listenes to that device's events and renders an
 * indicator to screen. 
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
  background (0.6638, 0.16, 0.22); // a bluish-grey background.
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
  color fillColor;
  CustomCursor( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    fillColor = color( random(1.0), 1.0, 1.0 );
  }

  void draw()
  {
    fill(fillColor);
    ellipse( x, y, 40, 40 );
  }

  // a pointer event handler
  void pointerMoved( Pointer p )
  {
    x = p.x();
    y = p.y();
  }
}

