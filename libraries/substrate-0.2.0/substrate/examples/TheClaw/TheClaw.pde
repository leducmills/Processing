/**
 * (c) oblong industries, inc. 2012
 *
 * The Claw chooses.
 * Rotate to close the claw.
 */

import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;
ArrayList<Claw> claws;
ArrayList<Prize> prizes;
float clawSize = 55.0f;

void setup()
{
  size( 1024, 768 );
  substrate = new Substrate(this);
  colorMode(HSB, 1.0f);
  smooth();

  claws = new ArrayList<Claw>();
  prizes = new ArrayList<Prize>();
  createPrizes();
}

void draw()
{
  background(1.0f);

  for ( int i = 0; i < prizes.size() - 1; ++i )
  {
    Prize p = prizes.get(i);
    for ( int j = i + 1; j < prizes.size(); ++j )
    {
      p.collide( prizes.get(j) );
    }
  }
  for ( Prize p : prizes )
  {
    p.update();
    p.draw();
  }
  for ( Claw c : claws )
  {
    c.draw();
  }

  for ( int i = claws.size() - 1; i >= 0; --i )
  { // remove dead claws
    if ( claws.get(i).getIsDead() )
    {
      claws.remove(i);
    }
  }
}

void pointerAppeared(Pointer p)
{
  claws.add( new Claw( p, clawSize + 5 ) );
}

void pointerVanished(Pointer p)
{
}

void createPrizes()
{
  for ( int i = 0; i < 27; ++i )
  {
    prizes.add( new Prize( random(width), random(height), clawSize) );
  }
}

// returns the claw that is closed around position x, y
// returns null if no claw is grasping given point
Claw getGraspingClaw(float x, float y)
{
  for ( Claw c : claws )
  {
    if ( c.getIsClosed() && dist(c.x, c.y, x, y) < c.radius )
    {
      return c;
    }
  }
  return null;
}


