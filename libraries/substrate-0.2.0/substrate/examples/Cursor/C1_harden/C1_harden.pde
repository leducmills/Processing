/**
 * (c)  oblong industries, inc.  2012
 *
 * Loop through all the pointers and draw an indicator
 * showing the hard/soft state of every connected device.
 */

import com.oblong.gspeak.*;

// the object that will give us access to data from g-speak.
Substrate substrate;

void setup () {
  // connect to g-speak server
  substrate = new Substrate (this);
  smooth ();
  size (800, 800);
}

void draw () {
  background (49, 49, 59); // a bluish-grey background.
  for (Pointer p : substrate.pointers.values())
  {
    if (p.isSoft())
    {
      fill (255);
      ellipse( p.x(), p.y(), 60, 60 );
    }
    else
    {
      fill (200);
      ellipse( p.x(), p.y(), 40, 40 );  
    }
  }
}
