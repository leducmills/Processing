// this function draws a cylinder using beginShape / endShape

int cylNum=-1;
float cylX[],cylZ[];

void cylinder(float w,float h) {
  // num is set to the value of slCylRes, rounded to an integer
  cylNum=int(slCylRes);

  pushMatrix();
  scale(w,h,w);
  
  // draw sides of cylinder
  for(int i=0; i<cylNum-1; i++) {
    beginShape(QUAD_STRIP);

    // bottom vertices
    vertex(cylX[i],-1,cylZ[i]);
    vertex(cylX[i+1],-1,cylZ[i+1]);

    // top vertices
    vertex(cylX[i],1,cylZ[i]);
    vertex(cylX[i+1],1,cylZ[i+1]);
    
    endShape();
  }
  
  beginShape(TRIANGLE_FAN);
  vertex(0,1,0);
  for(int i=0; i<cylNum; i++) vertex(cylX[i],1,cylZ[i]);
  endShape();
  
  beginShape(TRIANGLE_FAN);
  vertex(0,-1,0);
  for(int i=0; i<cylNum; i++) vertex(cylX[i],-1,cylZ[i]);
  endShape();
  
  popMatrix();
}

// pre-generates the data used to generate the cylinder.
// this saves us from calculating them except when needed.
void cylinderDetail(int _num) {
  float deg;
  
  cylNum=_num;
  cylX=new float[cylNum];
  cylZ=new float[cylNum];
  
  // calculate the degrees per rotation
  deg=(TWO_PI/(float)(cylNum-1));
  
  // calculate cylNum points on a circle
  for(int i=0; i<cylNum; i++) {
    cylX[i]=cos(i*deg);
    cylZ[i]=sin(i*deg);
  }
}
