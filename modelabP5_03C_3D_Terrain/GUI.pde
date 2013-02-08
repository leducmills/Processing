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
  
  slGridResolution=50;
  controlP5.addSlider("slGridResolution", // name, must match variable name
    5,200, // min and max values
    slGridResolution, // the default value
    100,20, // X,Y position of slider
    100,13); // width and height of slider

  noiseXD=50;
  controlP5.addSlider("noiseXD", // name, must match variable name
    5,200, // min and max values
    noiseXD, // the default value
    100,35, // X,Y position of slider
    100,13); // width and height of slider
    
  noiseYD=noiseXD;
  controlP5.addSlider("noiseYD", // name, must match variable name
    5,200, // min and max values
    noiseYD, // the default value
    100,50, // X,Y position of slider
    100,13); // width and height of slider

  Z=100;
  controlP5.addSlider("Z", // name, must match variable name
    5,400, // min and max values
    Z, // the default value
    100,65, // X,Y position of slider
    100,13); // width and height of slider
 
  // add a "bang" input, a button that triggers a custom function.
  // we'll use it to regenerate the mesh
  controlP5.addBang("generateMesh",20,20,20,20);
  
    // add toggle switch
  controlP5.addToggle("toggleSolid",
    300,20, // X,Y position
    20,20); // width and height
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
