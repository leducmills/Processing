/**
 * (c) oblong industries, inc. 2012
 *
 * Create a custom cursor object for each connected device
 * that listenes to that device's events. Listens for harden
 * and soften events.
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
  color fillColor;
  color softColor;
  color hardColor;
  CustomCursor( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    softColor = color( random(0.0, 0.3), 1.0f, 1.0f );
    hardColor = color( random(0.4, 0.6), 1.0f, 0.8f );
    fillColor = softColor;
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

  void pointerHardened( Pointer p )
  {
    fillColor = hardColor;
  }

  void pointerSoftened( Pointer p )
  {
    fillColor = softColor;
  }
}

