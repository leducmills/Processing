/**
 * (c)  oblong industries, inc.  2012
 *
 * Demonstatates how to display a cursor for each connected device with position
 * and rotation, and adds some a simple rain inspired particle system to help
 * visualize the possibilities this interaction affords.
 */

import com.oblong.gspeak.*;

float gravity         = -0.25;  // strength of gravity on the drops
float elasticity      = 0.2;    // "bounciness" of the splash
float max_drop_size   = 2.0;    // radius of a new drop
float min_drop_size   = 0.5;    // minimum radius of a droplet
int   num_subdroplets = 5;      // number of droplets per splash
float line_weight     = 2.0;    // thickness of the cursor
float line_length     = 250;    // length of the cursor
int   max_drops       = 240;    // maximum number of drops at a time

// the object that will give us access to data from g-speak.
Substrate substrate;

ArrayList<LineCursor> cursors;
ArrayList<Drop> drops;

void setup () {
  size (800, 800);
  smooth ();

  // connect to g-speak server
  substrate = new Substrate (this);
  cursors = new ArrayList<LineCursor>();
  drops = new ArrayList<Drop>();
}

void draw ()
{
  //clear the backrgound
  background (29, 29, 39);

  // draw the cursors
  for ( LineCursor c : cursors )
  {
    c.draw();
  }

  // rain a new drop
  if (drops.size() < max_drops)
    drops.add (new Drop());

  // draw all of our drops
  for (int i = 0; i < drops.size (); i++)
  {
    Drop d = drops.get(i);
    d.draw();

    // remove any drops that are dead
    if (d.isDead())
    {
      drops.remove(d);
      i--;
    }
  }
}

void pointerAppeared(Pointer p)
{
  cursors.add( new LineCursor(p) );
}

// A line cursor that reacts to both movement and rotation
// (declared 'public' so pointers can call its methods)
public class LineCursor
{
  float x, y;
  float angle, length;
  LineCursor( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    angle = 0;
    length = line_length;
  }

  // draw the cursor!
  void draw()
  {
    noFill();
    stroke(255);
    strokeWeight(line_weight);
    line(x1(), y1(), x2(), y2());
  }

  // methods for determining the points of the cursor line
  float x1()
  { 
    return x - length * 0.5 * cos(radians(angle));
  }

  float y1()
  { 
    return y - length * 0.5 * sin(radians(angle));
  }

  float x2()
  { 
    return x + length * 0.5 * cos(radians(angle));
  }

  float y2()
  { 
    return y + length * 0.5 * sin(radians(angle));
  }

  // a pointer event handler
  void pointerMoved( Pointer p )
  {
    x = p.x();
    y = p.y();
    angle = p.angle();
  }
}

// A drop object that rains from the sky and splashes when it hits things
public class Drop
{
  float x, y, px, py;
  float vx, vy;
  float radius;
  float alpha;
  ArrayList <Drop> droplets;

  Drop()
  {
    this.y = -max_drop_size;
    this.x = random(width);
    this.vx = 0;
    this.vy = 0;
    this.radius = max_drop_size;
    alpha = 255;
    this.droplets = new ArrayList<Drop>();
  }

  Drop(float x, float y)
  {
    this.y = y;
    this.x = x;
    this.vx = 0;
    this.vy = 0;
    this.radius = 10;
    alpha = 255;
    this.droplets = new ArrayList<Drop>();
  }

  void draw()
  { // if we haven't yet splashed, update and draw ourselves
    if (droplets.size() == 0)
    {
      // update the drop's position and velocity
      vy -= gravity;
      px = x;
      py = y;
      x += vx;
      y += vy;

      // splash if we hit a cursor
      for ( LineCursor c : cursors)
      {
        if (crossedLineSegment (c.x1(), c.y1(), c.x2(), c.y2()))
          splash(c.angle);
      }

      // splash if we hit the "ground"
      if (y >= height  &&  ! isDead ())
      {
        y = height;
        splash();
      }

      // actualy draw the drop
      noStroke();
      fill(255, alpha);
      ellipse (x, y, radius * 2.0, radius * 2.0);
    }
    // otherwise, draw all of our droplets (and their droplets (...)...)...
    else
    {
      for (Drop d : droplets)
      {
        d.draw();
      }
    }
  }

  // determine if the drop has splashed to nothingness
  boolean isDead ()
  {
    // we're dead if our radius is less than the minimum
    if (radius < min_drop_size)
      return true;
    // if we've splashed, see if all of our droplets are dead
    else if (droplets.size() > 0)
    {
      for (Drop d : droplets)
      {
        if (! d.isDead())
          return false;
      }
      return true;
    }
    // otherwise we're still alive!
    return false;
  }

  // detect if we've intersected a given line segment defined by two points
  boolean crossedLineSegment(float x1, float y1, float x2, float y2)
  {
    float x3 = px;
    float y3 = py;
    float x4 = x;
    float y4 = y;
    float denominator = (y4-y3)*(x2-x1)-(x4-x3)*(y2-y1);
    float a = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3)) / denominator;
    float b = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3)) / denominator;

    return (0 <= a && a <= 1 && 0 <= b && b <= 1);
  }

  void splash()
  { 
    splash (0);
  }

  void splash(float angle)
  { // don't splash if we've reached the minimum size
    if (radius < min_drop_size)
      return;

    // return to the correct side of the intersected object
    x -= vx;
    y -= vy;

    // make a splash with a number of droplets!
    for (int i = 0; i < num_subdroplets; i++)
    {
      Drop d = new Drop (x, y);

      // set velocity based on current velocity, elasticity, and angle of incidence
      float v = sqrt(vx*vx + vy*vy); // current velocity
      v *= elasticity * (1.0 + random (0.25)); // dampened velocity

      // this is some totally bogus approximate math for calculating bounce
      float old_drop_angle = degrees(atan2(vy, vx)); // current angle of the drop
      float angle_delta = angle - old_drop_angle + random (40.0) - 20.0; // angle with randomness
      d.vy = v * sin(radians(angle_delta)); //new horizontal velocity based on angles
      d.vx = v * cos(radians(angle_delta)); // new vertical velocity based on angles

      // set radius and alpha based on size of current drop
      d.radius = radius * 0.5;
      d.alpha = 255 * (d.radius / max_drop_size);

      // add it to the list of droplets
      droplets.add(d);
    }
  }
}

