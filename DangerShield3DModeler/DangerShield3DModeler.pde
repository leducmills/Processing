import processing.serial.*;
import processing.opengl.*;

Serial myPort; // Initialize the Serial Object
boolean serial = true; // Define if you're using serial communication

private SensorInterface dangerShield;
ArrayList<Point> points = new ArrayList<Point>(); 
ArrayList<Point> selPoints = new ArrayList<Point>(); 
ArrayList<Line> lines = new ArrayList<Line>(); 
ArrayList<Shape> shapes = new ArrayList<Shape>(); 
int thresholdDist = 50;


public void setup() {
  size(800, 600, OPENGL);

  if (serial) {
    String portName = Serial.list()[4]; // Get the first port myPort = new Serial(this, portName, 9600); myPort.bufferUntil('\n');
  }
  dangerShield = new SensorInterface(); // Initialize the GloveInterface Object
}


public void draw() {
  background(0);

  switch (dangerShield.currentFinger) { 
  case 0:
    movePoint();
    break;
  case 1:
    addPoint();
    break;
  case 2:
    addLine();
    break;
  case 3:
    addShape();
    break;
  }

  dangerShield.draw(); 
  drawClosestPoint();
  for (Point pt : points) { 
    pt.draw();
  }
  for (Line ln : lines) {
    ln.draw();
  }
  for (Shape srf : shapes) { 
    srf.draw();
  }

  dangerShield.drawData();
}

void movePoint() {
  for (Point pt : points) {
    if (glove.pos.dist(pt.pos) < thresholdDist) { 
      pt.setPos(glove.pos);
    }
  }
}

void addPoint() {
  Point tempPt = new Point(glove.pos.get()); 
  boolean tooClose = false;
  for (Point pt : points) {
    if (tempPt.pos.dist(pt.pos) < thresholdDist) { 
      tooClose = true;
    }
  }
  if (!tooClose) { 
    points.add(tempPt);
  }
}


void addLine() {
  for (Point pt : points) {
    if (glove.pos.dist(pt.pos) < thresholdDist) { 
      pt.select();
      if (!selPoints.contains(pt)) {
        selPoints.add(pt);
      }
      if (selPoints.size() > 1) {
        Line lineTemp = new Line(selPoints.get(0), selPoints.get(1)); 
        lines.add(lineTemp);
        unSelectAll();
      }
    }
  }
}

private void addShape() { 
  for (Point pt : points) {
    if (glove.pos.dist(pt.pos) < thresholdDist) { 
      pt.select();
      if (!selPoints.contains(pt)) {
        selPoints.add(pt);
      }
      if (selPoints.size() > 2) {
        Shape surfTemp = new Shape(selPoints); 
        shapes.add(surfTemp);
        unSelectAll();
      }
    }
  }
}

void unSelectAll() {
  for (Point pt : points) {
    pt.unSelect();
  }
  selPoints.clear();
}

void drawClosestPoint() { 
  for (Point pt : points) {
    if (glove.pos.dist(pt.pos) < thresholdDist) { 
      pushStyle();
      stroke(0, 150, 200);
      strokeWeight(15);
      point(pt.pos.x, pt.pos.y, pt.pos.z);
      popStyle();
    }
  }
}

public void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n'); 
  if (inString != null) {
    String[] fingerStrings = inString.split(" "); 
    if (fingerStrings.length == 4) {
      dangerShield.setFingerValues(fingerStrings);
    }
  }
}

public void keyPressed() { 
  switch (key) {
  case '1':
    glove.calibrateFinger(0, 0);
    break;
  case '2':
    glove.calibrateFinger(1, 0);
    break;
  case '3':
    glove.calibrateFinger(2, 0);
    break;
  case '4':
    glove.calibrateFinger(3, 0);
    break;
  case 'q':
    glove.calibrateFinger(0, 1);
    break;
  case 'w':
    glove.calibrateFinger(1, 1);
    break;
  case 'e':
    glove.calibrateFinger(2, 1);
    break;
  case 'r':
    glove.calibrateFinger(3, 1);
    break;
  case 'd':
    record = true;
    break;
  }
}

