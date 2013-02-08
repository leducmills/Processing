public class Paddle
{
  // polar coordinates of paddle center
  float theta;
  float r;
  // radians of arc coverage
  float spread;
  float forgiveness;
  float epsilon = 0.000001f;
  boolean isDead;
  color paddleColor;

  Paddle(float aRadius, Pointer p)
  {
    p.addEventListener( this );
    isDead = false;

    theta = -PI/2;
    spread = PI/4.0f;
    r = aRadius;
    forgiveness = 2 * PI / r;
    paddleColor = color( random(1.0), 1.0, 1.0 );
  }

  public void draw()
  {
    strokeWeight(4.0f);
    noFill();
    stroke(paddleColor);
    arc( 0, 0, r * 2, r * 2, theta - spread, theta + spread );
  }

  public void pointerMoved(Pointer p)
  { // will need to adjust this so we just use angle delta (maybe add to pointer)
    theta = (p.angle() - 90.0f) * PI / 180.0f;
  }

  public void pointerVanished(Pointer p)
  {
    p.removeEventListener( this );
    isDead = true;
  }

  public boolean intersects( float aTheta, float aR, float velocity )
  {
    if ( (aR <= r + epsilon && velocity > 0 && aR + velocity >= r - epsilon ) || // moving out past us
    (aR >= r - epsilon && velocity < 0 && aR + velocity <= r + epsilon ) ) // moving in past us
    { // if it would pass by us in the next time step
      if ( aTheta > theta - spread - forgiveness && aTheta < theta + spread + forgiveness )
      { // if inside our arc
        return true;
      }
    }
    return false;
  }
}

