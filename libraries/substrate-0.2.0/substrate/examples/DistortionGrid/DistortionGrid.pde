/**
 * (c) oblong industries, inc. 2012
 *
 * Grid elements distort around devices and match the
 * rotation of nearby devices
 */
 
import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;


Substrate substrate;
GridElement elements[];
int rows = 20;
int columns = 40;
float minSquareSize = 12.0f;
// the amount of warp per-pointer
float warpAmount = 48.0f;
// how large a region is warped by a single pointer
float warpRadius = 120.0f;

void setup()
{
  size( 1024, 768 );
  substrate = new Substrate(this);
  elements = new GridElement[ rows * columns ];

  float size = min( (float) width / columns, (float) height / rows );
  float offsetX = (width - size * (columns - 1)) / 2;
  float offsetY = (height - size * (rows - 1)) / 2;
  for ( int x = 0; x < columns; ++x )
  {
    for ( int y = 0; y < rows; ++y )
    {
      elements[ y * columns + x ] = new GridElement( x * size + offsetX, y * size + offsetY );
    }
  }

  smooth();
  colorMode(HSB, 1.0f);
  rectMode(CENTER);
}

void draw()
{
  updateGrid();
  background(0.2f);
  for ( GridElement g : elements )
  {
    g.draw();
  }
}

void updateGrid()
{
  for ( Pointer p : substrate.pointers.values() )
  {
    for ( GridElement g : elements )
    {
      g.respond(p);
    }
  }

  for ( GridElement g : elements )
  {
    g.respond(mouseX, mouseY);
  }
}


