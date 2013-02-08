class Ball
{
  // polar coordinates for position (makes hit detection easy)
  float theta;
  float r;
  float velocity;
  float size;
  Ball()
  {
    r = 0.0f;
    velocity = 3.0f;
    randomizeAngle();
    size = 12.0f;
  }

  void randomizeAngle()
  {
    theta = random( -PI, 0.0f );
  }

  void draw()
  {
    r += velocity;
    if ( r < 0 )
    {
      r = 0;
      velocity *= -1.0f;
      randomizeAngle();
    }

    float x = cos(theta) * r;
    float y = sin(theta) * r;

    if ( x + centerX < 0 || x + centerX > width || y + centerY < 0 )
    {
      restart();
    }

    fill(0.0f, 1.0f, 1.0f);
    noStroke();
    ellipse( x, y, size, size );
  }
}

