class Prize
{
  float x, y;
  float px, py;
  float radius;
  float friction;
  float gravity;
  int   fillColor;

  Prize(float ax, float ay, float aRadius)
  {
    x = ax;
    y = ay;
    px = ax - 5;
    py = ay;
    radius = aRadius;

    gravity = 0.65f;
    friction = 0.725f;
    float hue = floor(random(0.2f, 0.65f) * 20.0f) / 20.0f;
    fillColor = color( hue, 1.0f, 0.95f );
  }

  void collide(Prize neighbor)
  {
    float dx = neighbor.x - x;
    float dy = neighbor.y - y;
    float r2 = (radius + neighbor.radius) * (radius + neighbor.radius);
    float dist2 = (dx * dx) + (dy * dy);
    if ( dist2 < r2 )
    {
      float desiredDistance = radius + neighbor.radius;
      float angle = atan2(dy, dx);
      float xShift = cos(angle) * desiredDistance + x - neighbor.x;
      float yShift = sin(angle) * desiredDistance + y - neighbor.y;
      float weight = 1.0f - radius/desiredDistance;
      float recoil = 0.985f;
      weight *= recoil;
      x -= xShift * weight;
      y -= yShift * weight;
      neighbor.x += xShift * (1.0f - weight);
      neighbor.y += yShift * (1.0f - weight);
    }
  }

  void update()
  {
    Claw c = getGraspingClaw( x, y );
    if ( c != null )
    {
      x = c.x;
      y = c.y;
      px = c.px;
      py = c.py;
    }
    else
    {
      integrate();
    }
  }

  void draw()
  {
    noStroke();
    fill( fillColor );
    ellipse(x, y, radius*2, radius*2);
  }

  private void integrate()
  {
    float dx = x - px;
    float dy = (y + gravity) - py;
    x = x + dx * friction;
    y = y + dy * friction;
    if ( y > height - radius )
    {
      y = height - radius;
      dy *= -friction;
      dx *= friction;
    }
    if ( x > width - radius )
    {
      x = width - radius;
      dx *= -friction;
      dy *= friction;
    }
    else if ( x < radius )
    {
      x = radius;
      dx *= -friction;
      dy *= friction;
    }
    px = x - dx;
    py = y - dy;
  }
}

