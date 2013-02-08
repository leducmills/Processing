/**
 A brush that draws triangles
 */

class TriangleBrush extends Brush
{

  TriangleBrush(Pointer p)
  {
    super(p, 48);
  }

  Brush nextBrush(Pointer p)
  {
    return new RibbonBrush(p);
  }

  void draw()
  {
    noStroke();
    fill(baseColor);
    beginShape(PGraphics.TRIANGLES);
    for ( int i = 1; i != positions.length-1; ++i )
    {
      float x = positions[i].x;
      float y = positions[i].y;
      float px = positions[i-1].x;
      float py = positions[i-1].y;
      float dx = x - px;
      float dy = y - py;
      PVector dir = new PVector(dx, dy);
      dir.rotate(PConstants.PI / 2.0f);
      dir.mult(0.66f);
      float x1 = x - dir.x;
      float y1 = y - dir.y;
      float x2 = x + dir.x;
      float y2 = y + dir.y;
      vertex(px, py);
      vertex(x1, y1);
      vertex(x2, y2);
    }
    endShape();

    if ( positions[0].x == positions[positions.length-1].x &&
      positions[0].y == positions[positions.length-1].y )
    {
      triangle( positions[0].x - 10, positions[0].y, 
      positions[0].x, positions[0].y - 20, 
      positions[0].x + 10, positions[0].y);
    }
  }
}

