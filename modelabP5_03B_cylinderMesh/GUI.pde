// initializes the controlP5 GUI

void initControllers() {
  // initialize an instance of ControlP5
  controlP5 = new ControlP5(this);
  
  // we are using a white background, so set the color of
  // text labels to black
  controlP5.setColorLabel(color(0,0,0));
    
  slW=40;
  controlP5.addSlider("slW", // name, must match variable name
    20,100, // min and max values
    slW, // the default value
    20,20, // X,Y position of slider
    100,13); // width and height of slider

  slH=120;
  controlP5.addSlider("slH", // name, must match variable name
    20,200, // min and max values
    slH, // the default value
    20,35, // X,Y position of slider
    100,13); // width and height of slider

  slCylRes=12;
  controlP5.addSlider("slCylRes", // name, must match variable name
    6,60, // min and max values
    slCylRes, // the default value
    20,50, // X,Y position of slider
    100,13); // width and height of slider
}
