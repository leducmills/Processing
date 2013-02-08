
//Function for detecting if mouse is over an active vertex
void hitDetection() {

  for (int i = 0; i < points.length; i++) {

    x = screenX((float)points[i].x, (float)points[i].y, (float)points[i].z);
    y = screenY((float)points[i].x, (float)points[i].y, (float)points[i].z);
    //println(x + " " + y);
    Vec2D v2d = new Vec2D(x, y);

    mouseOverVectors = (Vec2D[])append(mouseOverVectors, v2d);

    if (x > mouseX-3 && x < mouseX+3 && y > mouseY-3 && y < mouseY+3) {
      vertexMouseOver = i;
    }
  }
}

//help text when mouse is over buttons
void doMouseOvers() {

  textSize(18);
  fill(50);
  text(version, 100, 90, 0);

  if (controlP5.controller("Hull").isInside()) {
    message = "Toggles the convex hull (fill).";
  }

  if (controlP5.controller("WireFrame").isInside()) {
    message = "Toggles wireframe - works with the Hull button on.";
  }

  if (controlP5.controller("Grid").isInside()) {
    message = "Turns the background grid on or off.";
  }

  if (controlP5.controller("Export").isInside()) {
    message = "Exports your shape as an .stl file for 3D printing.";
  }

  if (controlP5.controller("Spline").isInside()) {
    message = "Connects the points with spines (curves).";
  }

  if (controlP5.controller("Edit").isInside()) {
    message = "Turns on edit mode, where you can click and drag points to alter the shape.";
  }

  if (controlP5.controller("Save").isInside()) {
    message = "Save your shape to a text file that you can load later.";
  }

  if (controlP5.controller("Load").isInside()) {
    message = "Load a shape that you have previously saved.";
  }

  if (controlP5.controller("Knot").isInside()) {
    message = "Make a knot.";
  }

  if (controlP5.controller("ExportKnot").isInside()) {
    message = "Export knot as an STL file.";
  }

  if (controlP5.controller("ClearKnot").isInside()) {
    message = "Clears the knot so you can start a new path.";
  }

  if (controlP5.controller("CloseKnot").isInside()) {
    message = "Closes your knot.";
  }


  if (message != null && controlP5.window(this).isMouseOver()) {
    textSize(14);
    text(message, 100, 400, 0);
  }
}

