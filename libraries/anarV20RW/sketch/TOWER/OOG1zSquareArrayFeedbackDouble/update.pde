

void updateParameters() {

  float hStep = 0;

  // distance of measure point to surface  
  int h = 5;
  
  // new object for displaying measure points
  Obj points = new Obj();

  for (int i=0; i<faces.numOfFaces(); i++) {
    Face f = faces.face(i);

    // find center of the face  
    float[] w = new float[f.numOfPts()];
    for (int j=0; j<w.length; j++) w[j] = 1;
    PtBaryRedux centre = new PtBaryRedux(f,w);
    
    // create a point normal to the face at the center
    PtNormal n = new PtNormal(f.pt(0),centre,f.pt(1),h);

    // add normal to object for visualization    
    points.add(n);
    
    // compute the distance to the "sun"
    float dist = (float) n.length(sun);
    float l = (float) centre.length(sun);
    
  // compute step according to cosine theorem
  // this approximation is planar 
    hStep = acos( (sq(h) + sq(l) - sq(dist)) / (2 * h * l));
    // reduce amplitude to smooth movement
    hStep /= 50;
    

    // change rotation selecting randomly on each axis
    // this is necessary to circumvent the planarity of the step approximation 
    float prob = random(1.0f);
    
    int change = 0;
    if (prob < 0.333f) {
      clockwiseX[i] = changeRotation(myArrayX[i], clockwiseX[i], hStep, distance[i][0], dist );
      change = 0;
    }  
    else if (prob < 0.666f) {
      clockwiseY[i] = changeRotation(myArrayY[i], clockwiseY[i], hStep, distance[i][1], dist );
      change = 1;    
    }
    else {
      clockwiseZ[i] = changeRotation(myArrayZ[i], clockwiseZ[i], hStep, distance[i][2], dist );
      change = 2;
    }
    // store previous distance
    distance[i][change] = dist;
  }
  // remove comment to se the measure points
  //points.draw();  
}



// update parameters for rotation according to step
boolean changeRotation(Param p, boolean clock, float step, float dist, float newDist ) {
  
    // clockwise
    if (clock) {
      if (dist>newDist) p.set(p.get() + step);
      else  {
        p.set(p.get() - step);
        clock = false;
      }
    }
    // or anti clockwise
    else {
      if (dist>newDist) p.set(p.get() - step);
      else {
        p.set(p.get() + step);
        clock = true;
      }
    }
 
    return clock;
}




