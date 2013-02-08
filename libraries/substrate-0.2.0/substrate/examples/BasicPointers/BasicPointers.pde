/**
 * (c) oblong industries, inc. 2012
 *
 * Simple application that shows a cursor for every connected device.
 */

import com.oblong.gspeak.*;

// the object that will give us access to data from g-speak.
Substrate substrate;

void setup () {
  size (800, 800);
  // connect to g-speak server
  substrate = new Substrate (this);
  smooth ();
}

void draw () {
  background (49, 49, 59); // a bluish-grey background.
  substrate.drawPointers();
}
