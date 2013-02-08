/**
 * (c) oblong industries, inc. 2012
 *
 * Radial pong-like game.
 */

import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;
float centerX, centerY;
ArrayList<Paddle> paddles;
Ball ball;
float paddleRadius = 200.0f;
float radiusIncrement = 40.0f;

public void setup()
{
  size( 1024, 768 );
  substrate = new Substrate(this);
  centerX = width * 0.5f;
  centerY = height * 0.75f;
  colorMode( HSB, 1.0f );
  smooth();

  paddles = new ArrayList<RadPong.Paddle>();
  ball = new Ball();
}

public void restart()
{
  println("Restarting");
  ball.r = 0;
  ball.theta = random( -PI, 0.0f );
  for ( Paddle p : paddles )
  {
    p.spread = PI/4.0f;
  }
}

public void draw()
{
  background(0.4f);

  pushMatrix();
  translate(centerX, centerY);
  strokeWeight(1.0f);
  noFill();
  stroke(0.8f);
  line( -centerX, 0, centerX, 0 );
  arc( 0.0f, 0.0f, 14.0f, 14.0f, -PI, 0 );
  ball.draw();

  for ( Paddle p : paddles )
  {
    p.draw();
    if ( p.intersects(ball.theta, ball.r, ball.velocity) )
    {
      ball.r = p.r; // move to point of collision
      ball.velocity *= -1.0f;
      if ( p.spread > PI * 0.025f )
      { 
        p.spread -= PI * 0.015f;
      }
      break; // can only bounce off one
    }
  }

  popMatrix();

  for ( int i = paddles.size() - 1; i >= 0; --i )
  {
    if ( paddles.get(i).isDead )
    {
      paddles.remove(i);
    }
  }
}

public void pointerAppeared(Pointer p)
{
  paddles.add( new Paddle(paddleRadius, p) );
  paddleRadius += radiusIncrement;
}

