import anar.*;
import processing.opengl.*;




Obj myObj;
Sliders mySliders;

int n = 10;
Param[] myArrayZ;
Param[] myArrayX;
Param[] myArrayY;

Pt sun;
boolean[] clockwiseZ;
boolean[] clockwiseX;
boolean[] clockwiseY;
float[][] distance;
Obj faces;

void setup() {
  size(1000, 600, OPENGL);
  Anar.init(this);

  initForm();
  initSun();
}


void initSun() {

  // initialise distance array
  distance = new float[myArrayZ.length][3];
  for (int i=0; i<distance.length; i++) {
    distance[i][0] = 0;
    distance[i][1] = 0;
    distance[i][2] = 0;
  }
  
  // initialize turn direction array
  clockwiseZ = new boolean[myArrayZ.length];
  clockwiseX = new boolean[myArrayZ.length];
  clockwiseY = new boolean[myArrayZ.length];
  for (int i=0; i<clockwiseZ.length; i++) {
    clockwiseZ[i] = true;
    clockwiseX[i] = true;
    clockwiseY[i] = true;
  }
  // create "sun"
  sun = Anar.Pt(50,10,50);
  myObj.add(sun);

  // add "sun" parameters to sliders
  mySliders = new Sliders();
  mySliders.add(sun);

   
 
}

void initForm() {
  //Create a new Object to store our shape
  myObj = new Obj();  
  //Create another object to store faces htat will be oriented toward the "sun"
  faces = new Obj();

  //Create a vertical translation defining the height of tower floors
  Transform tZ = new Translate(0,0,10);
  Transform tX = new Translate(10,0,0);

  //Create parameter array to store individual rotations values
  // use linear array instead of 2-dimensional
  myArrayZ = new Param[n*n];
  myArrayX = new Param[n*n];
  myArrayY = new Param[n*n];


  for (int i=0; i<myArrayZ.length/n; i++) {
    for (int j=0; j<myArrayZ.length/n; j++) {

      // transform 2 dimension i and j into linear index
      int index = j + n*i;
      //Create individual rotations randomly
      myArrayZ[index] = new Param(random(1.4f));
      myArrayX[index] = new Param(random(1.4f));
      myArrayY[index] = new Param(random(1.4f));

      //Define position translation
      Transform pos = new Transform();
      for(int k=0; k<j; k++) {
        pos.apply(tX);
      }
      for(int k=0; k<i; k++) {
        pos.apply(tZ);
      }

      //Add module according to position and rotation parameter
      myObj.add(createModule(pos, myArrayZ[index], myArrayX[index], myArrayY[index]));
    }
  }
  
  myObj.pts.render = new RenderPtsAll();

  //Center on the object
  Anar.camTarget(myObj);
}


void draw() {
  background(150);
  mySliders.draw();
  myObj.draw();
  updateParameters();
}

void keyPressed() {
  // reset shape 
  if (key == ' ') {
    initForm(); 
    initSun();
  }
}
