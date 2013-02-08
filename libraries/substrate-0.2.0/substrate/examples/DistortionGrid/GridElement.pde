class GridElement
{
  float x, y;
  float stiffness;
  float rot;
  float size;
  float targetSize;
  ArrayList<Pointer> influences;

  // to interact with multiple things without overflow,
  // we keep a separate accumulation that refreshes every frame
  float accumulatedSize;
  float accumulatedRotation;

  GridElement(float ax, float ay)
  {
    x = ax;
    y = ay;
    rot = 0.0f;
    size = 0.0f;
    targetSize = minSquareSize;
    stiffness = 0.175f;
    rot = 0;
  }

  void respond( float ax, float ay)
  {
    float dist2 = (ax - x) * (ax - x) + (ay - y) * (ay - y);
    swell(dist2);
  }

  void respond( Pointer p )
  {
    float dist2 = (p.x() - x) * (p.x() - x) + (p.y() - y) * (p.y() - y);
    swell(dist2);
    sway(dist2, p.angle());
  }

  private void sway(float distanceFromSwaying, float angle)
  {
    float maxDist = warpRadius*warpRadius;
    distanceFromSwaying = min(distanceFromSwaying, maxDist);
    accumulatedRotation += map( distanceFromSwaying, 0.0f, maxDist, angle * PI / 180.0f, 0.0f );
  }

  private void swell(float distanceFromSwelling)
  { // swell some amount
    float maxDist = warpRadius * warpRadius;
    distanceFromSwelling = min(distanceFromSwelling, maxDist);
    distanceFromSwelling = max(0, distanceFromSwelling);
    accumulatedSize += map( distanceFromSwelling, 0.0f, maxDist, warpAmount, 0.0f);
  }

  private void handleInfluences()
  {
    if ( accumulatedRotation != 0 )
    { 
      rot = accumulatedRotation;
    }
    if ( accumulatedSize != 0 )
    { 
      targetSize = minSquareSize + accumulatedSize;
    }
    else
    { 
      targetSize = minSquareSize;
    }
    accumulatedRotation = 0;
    accumulatedSize = 0;
  }

  void draw()
  {
    handleInfluences();
    // ease into new size
    size += (targetSize - size) * stiffness;
    float normRot = abs(rot / PI);
    float normSize = min(size, 60.0f) / 60.0f;

    float hue = map( normRot, 0.0f, 1.0f, 0.6f, 0.2f );
    float brightness = map( normSize, 0.0f, 1.0f, 0.5f, 1.0f );
    fill(hue, 1.0f, brightness);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(rot);
    rect( 0, 0, size, size );
    popMatrix();
  }
}

