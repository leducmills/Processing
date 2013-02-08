/**
 * (c) oblong industries, inc. 2012
 *
 * Simple photo gallery.
 * Swipe up on device to send images.
 * Swipe left/right to scroll through images.
 */

import com.oblong.gspeak.Substrate;
import com.oblong.gspeak.Pointer;

Substrate substrate;
ArrayList<Photo> photos;
ArrayList<Integrator> integrators;
int currentPhoto;
float margin = 10.0f;
float nextX = margin;
Integrator slidePosition;
Integrator instructionsX;
Integrator instructionsY;
String instructions = "Swipe up to add a photo";

void setup()
{
  size( 1024, 768 );
  substrate = new Substrate(this);
  photos = new ArrayList<Photo>();

  slidePosition = new Integrator();
  slidePosition.target = width/2;
  instructionsX = new Integrator();
  instructionsY = new Integrator();
  instructionsX.stiffness = 0.15f; // a little bit softer
  instructionsX.value = instructionsX.target = (width - textWidth(instructions))/2;
  instructionsY.target = height/2;
  instructionsY.value = height;
  integrators = new ArrayList<Integrator>();
  integrators.add(slidePosition);
  integrators.add(instructionsX);
  integrators.add(instructionsY);
}

void draw()
{
  // update slider
  for ( Integrator i : integrators )
  {
    i.step();
  }
  background(255);

  pushMatrix();
  // center on selected image
  translate(slidePosition.value, 0);
  for ( Photo p : photos )
  {
    p.draw();
  }
  popMatrix();

  drawInstructions();
}

void drawInstructions()
{
  fill(0);
  text(instructions, instructionsX.value, instructionsY.value);
}

void addPhoto(PImage img)
{
  photos.add(new Photo(img, nextX));
  nextX += img.width + margin;
  // move instructions
  instructionsX.target = 10;
  instructionsY.target = 20;
  // slide to recently added photo
  currentPhoto = photos.size() - 1;
  scrollToPhoto(currentPhoto);
}

void imageIngested(PImage img)
{
  addPhoto(img);
}

void pointerSwipedRight(Pointer p)
{
  previousPhoto();
}

void pointerSwipedLeft(Pointer p)
{    
  nextPhoto();
}

void pointerSwipedUp(Pointer p)
{
  substrate.requestImage(p);
}

void pointerSwipedDown(Pointer p)
{
}

void nextPhoto()
{
  ++currentPhoto;
  if ( currentPhoto >= photos.size() )
  {
    currentPhoto = 0;
  }
  scrollToPhoto(currentPhoto);
}

void previousPhoto()
{
  --currentPhoto;
  if ( currentPhoto < 0 )
  {
    currentPhoto = photos.size() - 1;
  }
  scrollToPhoto(currentPhoto);
}

void scrollToPhoto(int index)
{
  Photo ph = photos.get(index);
  if ( ph != null )
  { // center on photo
    slidePosition.target = (width - ph.w) * 0.5f - ph.x;
  }
  else
  {
    slidePosition.target = width * 0.5f;
  }
}

