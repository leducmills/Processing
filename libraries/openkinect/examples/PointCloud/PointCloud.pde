// Daniel Shiffman
// Kinect Point Cloud example
// http://www.shiffman.net
// https://github.com/shiffman/libfreenect/tree/master/wrappers/java/processing

import org.openkinect.*;
import org.openkinect.processing.*;



public static final int DEPTH_MIN = 500;
public static final int DEPTH_MAX = 3000;

public static final int[][] SPECTRUM = { 
  { 
    255, 255, 255
  }
  , 
  { 
    150, 253, 253
  }
  , { 
    50, 50, 253
  }
  , { 
    253, 50, 253
  }
  , { 
    253, 50, 50
  }
  , 
  { 
    253, 253, 50
  }
  , { 
    50, 253, 50
  }
};

public static final int NUM_COLORS = SPECTRUM.length*255;

public int[] colors = new int[NUM_COLORS];




// Kinect Library object
Kinect kinect;

float a = 0;

// Size of kinect image
int w = 640;
int h = 480;


// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  // We don't need the grayscale image in this example
  // so this makes it more efficient
  kinect.processDepthImage(false);

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  createColors();
}

void draw() {

  background(0);
  fill(255);
  textMode(SCREEN);
  text("Kinect FR: " + (int)kinect.getDepthFPS() + "\nProcessing FR: " + (int)frameRate, 10, 16);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 4;

  // Translate and rotate
  translate(width/2, height/2, -50);
  //rotateY(a);

  for (int x=0; x<w; x+=skip) {
    for (int y=0; y<h; y+=skip) {
      int offset = x+y*w;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      //println(rawDepth);
      
      if(x%100 == 0 && y%100==0) {
       println(rawDepth); 
      }
      
      PVector v = depthToWorld(x, y, rawDepth);

      float c = map(rawDepth, 500, 1000, 0, 255);
      stroke(c, 255, 255);
      
      //stroke(mapDepthToColor(rawDepth));
      //mapDepthToColor(rawDepth));

      pushMatrix();
      // Scale up by 200
      float factor = 200;
      translate(v.x*factor, v.y*factor, factor-v.z*factor);
      // Draw a point
      point(0, 0);
      popMatrix();
    }
  }

  // Rotate
  a += 0.015f;
  
//  stroke(mapDepthToColor(frameCount%(DEPTH_MAX-DEPTH_MIN)+DEPTH_MIN));
//  fill(mapDepthToColor(frameCount%(DEPTH_MAX-DEPTH_MIN)+DEPTH_MIN));
//  ellipseMode(CENTER);
//  ellipse(width/2,height/2,30,30);
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

void stop() {
  kinect.quit();
  super.stop();
}

private void createColors() {

  int[][] RGBcolors = new int[NUM_COLORS][4];

  int i, j, k = 0;
  for (i = 0; i < SPECTRUM.length - 1; i++) {
    // colors[i] = new int[4];
    for (j = 0; j < 256; j++) {
      RGBcolors[k][0] = (int) redoRange(j, SPECTRUM[i][0], 
      SPECTRUM[i + 1][0], 0, 255);
      RGBcolors[k][1] = (int) redoRange(j, SPECTRUM[i][1], 
      SPECTRUM[i + 1][1], 0, 255);
      RGBcolors[k][2] = (int) redoRange(j, SPECTRUM[i][2], 
      SPECTRUM[i + 1][2], 0, 255);
      RGBcolors[k][3] = 255;

      k++;
    }
  }

  for ( i =0; i<NUM_COLORS; i++) {
    colors[i] = color(RGBcolors[i][0], RGBcolors[i][1], RGBcolors[i][2], RGBcolors[i][3]);
  }
}

public static float redoRange( float value, float targetMin, float targetMax, 
float sourceMin, float sourceMax ) {
  return (value-sourceMin) * ((targetMax-targetMin)/(sourceMax-sourceMin)) + targetMin;
}

public static int mapDepthToColor(float depth) {
  return (int) redoRange( depth, 0, NUM_COLORS, DEPTH_MIN, DEPTH_MAX );
}

