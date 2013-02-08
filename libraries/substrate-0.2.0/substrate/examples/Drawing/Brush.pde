/**
A brush that follows an iOS pointer
inherited by other brushes to store pointer data
*/

// must be declared public, otherwise Substrate won't get access
// to call pointer methods
public class Brush {
  
  /**
   * Create a drawing tool that uses the provided pointer
   * to draw things
   * Will receive events from that pointer
   * @param p
   */
  PVector[] positions;
  int index;
  int baseColor;
  Tween life;
  float lifeStep;
  Pointer pointer;
  
  Brush(Pointer p, int historySize)
  {
    pointer = p;
    p.addEventListener(this);
    
    life = new Tween(1.0f, 0.0f, 1.2f);
    lifeStep = 0.0f;
    
    positions = new PVector[historySize];
    index = 0;
    for( int i = 0; i != positions.length; ++i )
    {
      positions[i] = new PVector(p.x(), p.y(), 0);
    }
    
    baseColor = color( 127 + random(127), 255, random(255) );
  }
  
  Brush nextBrush(Pointer p)
  {
    return new Brush(p, positions.length);
  }
  
  void dryOut()
  { // sad days
    println("Brush going away");
    pointer.removeEventListener( this );
    lifeStep = 1.0f/60.0f; // march forward at 60Hz
  }
  
  float getLife()
  {
    return life.getValue();
  }
  
  boolean isDry()
  {
    if( life.getComplete() ){
      pointer.removeEventListener(this);
      return true;
    }
    return false;
  }
  
  void updatePositions()
  {
    for( int i = positions.length-1; i > 0; --i )
    {
      positions[i].set(positions[i-1]);
    }
  }
  
  void update()
  {
    life.step(lifeStep); // move in time
  }
  
  void draw()
  {
    strokeWeight(4);
    stroke(baseColor);
    noFill();
    beginShape();
    for( int i = 0; i != positions.length; ++i )
    {
      vertex(positions[i].x, positions[i].y);
    }
    endShape();

    noFill();
    ellipse(positions[0].x, positions[0].y, 20, 20);
  }

  void pointerMoved(Pointer p)
  {
    positions[0].x = p.x();
    positions[0].y = p.y();
    updatePositions();
  }

  void pointerHardened(Pointer p)
  {
    p.reset();
  }

  void pointerVanished(Pointer p)
  {
    println("Pointer vanished");
    dryOut();
  }
}
