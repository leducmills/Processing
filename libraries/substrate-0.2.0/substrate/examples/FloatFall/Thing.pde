// thing that moves when touched
class Condensation
{
  float skyPosition;
  float groundPosition;
  float targetPosition;
  float x, y;
  float vy;
  float size;
  float gray;
  float speedLimit;
  Condensation( float aSize )
  {
    size = aSize;
    println("Size: " + size);
    vy = -( 1.0f + floor( random(1.0f) * 6.0f ) / 6.0f ) * 0.5f;
    x = random(size, width - size);
    float offset = map( floor(random(1.0f) * 10.0f)/10.0f, 0.0f, 1.0f, -80.0f, 120.0f );
    skyPosition = 100.0f + offset;

    groundPosition = height - 150.0f + map(size, minSize, maxSize, 0.0f, 80.0f);
    gray = map(size, minSize, maxSize, 0.5f, 0.95f );
    speedLimit = map( size, minSize, maxSize, 3.0f, 5.0f );

    targetPosition = random(1.0f) > 0.5f ? groundPosition : skyPosition;
    y = random(skyPosition, groundPosition);
  }

  boolean contains(float ax, float ay)
  {
    return dist(x, y, ax, ay) < size * 0.5f;
  }

  void draw()
  {
    y += max( min( (targetPosition - y) * 0.0565f, speedLimit ), -speedLimit );
    fill( gray );
    noStroke();
    ellipse( x, y, size, size );
  }

  void shift()
  {
    targetPosition = (targetPosition == skyPosition) ? groundPosition : skyPosition;
  }
}
