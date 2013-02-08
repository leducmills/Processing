/**
 * (c) oblong industries, inc. 2012
 * 
 * Creates a substrate pool server that receives events from pointers.
 * Run this before running other sketches, then leave it running in
 * the background.
 * As long a PoolServer is running, your other sketches won't need to
 * start the server, allowing you to launch them much faster.
 */

import com.oblong.gspeak.Substrate;

Substrate substrate;
PImage serverImage;

// REPLACE THIS STRING with something unique to you!
String serverName = "ben_sparkfun";


void setup () {
  substrate = new Substrate(this, serverName);
  serverImage = loadImage ("server.png");
}

void draw () {
  // just a little visual affirmation that the
  // server is indeed running.
  image (serverImage, 0, 0);  
}
