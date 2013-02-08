// PImage plus a position
class Photo
{
  PImage img;
  float x;
  float w, h;

  Photo(PImage img, float x)
  {
    if ( img != null )
    {
      this.img = img;
      this.x = x;
      w = img.width;
      h = img.height;
    }
  }

  void draw()
  { // vertically centered at position
    image(img, x, (height - h) * 0.5f);
  }
}

