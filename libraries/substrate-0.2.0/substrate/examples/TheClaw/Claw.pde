public class Claw
{
  float x, y;
  float px, py;
  float gap;
  float radius;
  float closedness;
  float arcSize;
  boolean isDead;

  Claw(Pointer p, float aRadius)
  {
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    px = p.x();
    py = p.y();
    gap = 4.0f;
    radius = aRadius;
    closedness = 0.0f;
    arcSize = PI/2;
    isDead = false;
  }

  void setLoc( float ax, float ay )
  {
    px = x;
    py = y;
    x = ax;
    y = ay;
  }

  void draw()
  {
    stroke(0.0f);
    strokeWeight(2);
    noFill();

    float leftStart = map( closedness, 0, 1.0f, PI, PI/2 );
    float rightStart = map( closedness, 0, 1.0f, -PI/2, 0 );
    // right side
    arc(x + gap, y, radius*2, radius*2, rightStart, rightStart + arcSize);
    // left side
    arc(x - gap, y, radius*2, radius*2, leftStart, leftStart + arcSize);
  }

  boolean getIsClosed()
  {
    return closedness > 0.425f;
  }

  boolean getIsDead()
  {
    return isDead;
  }

  void pointerMoved(Pointer p)
  {
    setLoc( p.x(), p.y() );
    closedness = min( map( abs(p.angle()), 0.0f, 60.0f, 0.0f, 1.0f ), 1.0f );
  }

  void pointerVanished(Pointer p)
  {
    p.removeEventListener(this);
    isDead = true;
  }
}
