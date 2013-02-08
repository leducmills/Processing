/**
 * (c) oblong industries, inc. 2012
 *
 * Brush-based drawing application.
 */

import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;
ArrayList<Brush> brushes;

void setup()
{
  size(1024, 768);
  substrate = new Substrate(this);
  smooth();
  // wait for images coming from the remote-data pool
  substrate.awaitImages("tcp://localhost/remote-data");
  brushes = new ArrayList<Brush>();
}

void draw()
{
  background(0);

  for ( Brush b : brushes )
  {
    b.update();
    b.draw();
  }
  for ( int i = brushes.size()-1; i >= 0; --i )
  {
    if ( brushes.get(i).isDry() )
    {
      brushes.remove(i);
    }
  }
}

void pointerAppeared(Pointer p)
{
  if ( random(1.0f) > 0.4f )
  {
    brushes.add(new RibbonBrush(p));
  }
  else
  {
    brushes.add(new TriangleBrush(p));
  }
  println("Got a pointer: " + p.provenance());
}

void pointerSwipedRight(Pointer p)
{
  println("Pointer swiped");

  // we might get a new brush
  Brush next = null;
  for (Brush b : brushes)
  {
    if ( b.pointer == p )
    { // kill off the current brush and make a new one
      b.dryOut();
      // get the "next" brush over from the current one
      next = b.nextBrush(p);
      // you could also just create a new brush if you like
      // next = new RibbonBrush(p);
    }
  }
  if ( next != null )
  { // if we got a new brush, add it
    brushes.add(next);
  }
}

