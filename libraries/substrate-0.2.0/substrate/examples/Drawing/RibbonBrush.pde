/**
A brush that draws meshy ribbons
*/

class RibbonBrush extends Brush
{

  RibbonBrush(Pointer p)
  {
    super(p, 32);
  }
  
  Brush nextBrush(Pointer p)
  {
   return new TriangleBrush(p); 
  }
  
  void draw()
  {
    stroke(0);
    strokeWeight(2);
    fill(baseColor);
    
    int end = (int) (getLife() * (positions.length - 1));
    beginShape(PGraphics.TRIANGLE_STRIP);
    vertex(positions[0].x, positions[0].y);    
    for( int i = 1; i < end; ++i )
    {
      float x = positions[i].x;
      float y = positions[i].y;
      float dx = x - positions[i-1].x;
      float dy = y - positions[i-1].y;
      PVector dir = new PVector(dx, dy);
      dir.rotate(PConstants.PI / 2.0f);
      float magnitude = dir.mag();
      magnitude = constrain(magnitude, 1.0f, 200.0f);
      dir.normalize();
      dir.mult(magnitude);
      float x1 = x - dir.x;
      float y1 = y - dir.y;
      float x2 = x + dir.x;
      float y2 = y + dir.y;
      vertex(x1, y1);
      vertex(x2, y2);
    }
    vertex(positions[end].x, positions[end].y);
    endShape();
  }
}
