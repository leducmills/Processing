// functions for setting up our controlP5 GUI and the Nav3D 
// camera controller. to receive mouse wheel events we have to 
// do a little Java magic, such as implementing the
// java.awt.event.MouseWheelListener interface (see end of this
// tab.)

void initControllers() {
  nav=new Nav3D(); 
  nav.rotX=PI/6;
  nav.rotY=PI/6;
  
  // create a listener for mouse wheel events
  frame.addMouseWheelListener(new MouseWheelInput());

  controlP5 = new ControlP5(this);
  controlP5.setColorLabel(color(0,0,0));
  
  // add a "bang" input, a button that triggers a custom function.
  // we'll use it to regenerate the mesh
  controlP5.addBang("generateMesh",20,20,20,20);
  
  // add a "bang" input to save file
  controlP5.addBang("saveFile",100,20,20,20);
}

// pass mouse and key events to our Nav3D instance
void mouseDragged() {
  // ignore mouse event if cursor is over controlP5 GUI elements
  if(controlP5.window(this).isMouseOver()) return;
  
  nav.mouseDragged();
}

void keyPressed() {
  nav.keyPressed();
}

// utility class to handle mouse wheel events
class MouseWheelInput implements MouseWheelListener{
  void mouseWheelMoved(MouseWheelEvent e) {
    nav.mouseWheelMoved(e.getWheelRotation());
  }
}
