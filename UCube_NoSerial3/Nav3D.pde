// utility class for controlling 3D camera. supports rotating
// by dragging the mouse,panning with shift-click and zooming 
// with the mouse wheel.

class Nav3D {
  float rotX,rotY;
  float tx,ty,tz;

  void transform() {
    translate(width/2,height/2);
    translate(tx,ty,tz);
    rotateY(rotY);
    rotateX(rotX);
  }
  
  void mouseDragged() {
    
    // calculate rotX and rotY by the relative change
    // in mouse position
    if(keyEvent!=null && keyEvent.isShiftDown()) {
      tx+=radians(mouseX-pmouseX)*10;
      ty+=radians(mouseY-pmouseY)*10;
    }
    else {
      rotY+=radians(mouseX-pmouseX);
      rotX-=radians(mouseY-pmouseY);
    }
  }
  
  void keyPressed() {
    if(key==CODED) {
      // check to see if CTRL is pressed
      if(keyEvent.isControlDown()) {
        // do zoom in the Z axis
        if(keyCode==UP) tz=tz+2;
        if(keyCode==DOWN) tz=tz-2;
      }
      // check to see if CTRL is pressed
      else if(keyEvent.isShiftDown()) {
        // do translations in X and Y axis
        if(keyCode==UP) ty=ty-2;
        if(keyCode==DOWN) ty=ty+2;
        if(keyCode==RIGHT) tx=tx+2;
        if(keyCode==LEFT) tx=tx-2;
      }
      else {
        // do rotations around X and Y axis
        if(keyCode==UP) rotX=rotX+radians(2);
        if(keyCode==DOWN) rotX=rotX-radians(2);
        if(keyCode==RIGHT) rotY=rotY+radians(2);
        if(keyCode==LEFT) rotY=rotY-radians(2);
      }
    }
    else {
      if(keyEvent.isControlDown()) {
        if(keyCode=='R') {
          println("Reset transformations.");
          tx=0;
          ty=0;
          tz=0;
          rotX=0;
          rotY=0;
        }
      }
    }
  }

//  void mouseWheelMoved(float step) {
//    tz=tz+step*15;
//  }
}
