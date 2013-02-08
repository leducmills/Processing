/**
 * (c) oblong industries, inc. 2012
 *
 * Elements float and fall when touched.
 * Double-tap on an element to 'touch' it
 */

import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;
ArrayList<Condensation> condensedElements;
float minSize = 40.0f;
float maxSize = 80.0f;
String instructions = "Double-tap on the clouds";

void setup()
{
  substrate = new Substrate(this);
  size(1024, 768);
  colorMode( HSB, 1.0f );
  condensedElements = new ArrayList<Condensation>();
  for (int size = (int) minSize; size < maxSize + 1; size += 2)
  {
    int numElements = (int) map( size, minSize, maxSize, 50, 8 );
    for ( int count = 0; count < numElements; ++count )
    {
      condensedElements.add( new Condensation(size) );
    }
  }
  smooth();
}

void draw()
{
  background(1.0f);
  for ( Condensation c : condensedElements )
  {
    c.draw();
  }
  fill( 1.0f, 1.0f, 1.0f );
  substrate.drawPointers();
  fill( 0.0f, 0.0f, 0.0f );
  text( instructions, (width - textWidth(instructions))/2, height/2 );
}

void pointerHardened(Pointer p)
{
  // check hits in front-to-back draw order
  for ( int i = condensedElements.size() - 1; i >= 0; --i )
  {
    if ( condensedElements.get(i).contains( p.x(), p.y() ) )
    {
      condensedElements.get(i).shift();
      break;
    }
  }
}


