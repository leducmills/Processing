

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
  // this approximation is planar so no variation in Z
    hStep = acos( (sq(h) + sq(l) - sq(dist)) / (2 * h * l));
    // reduce amplitude to smooth movement
    hStep /= 50;
    

    // update parameters according to step
    // either clockwise
    if (clockwise[i]) {
      if (distance[i]>dist) myArray[i].set(myArray[i].get() + hStep);
      else  {
        myArray[i].set(myArray[i].get() - hStep);
        clockwise[i] = false;
      }
    }
    // or anti clockwise
    else {
      if (distance[i]>dist) myArray[i].set(myArray[i].get() - hStep);
      else {
        myArray[i].set(myArray[i].get() + hStep);
        clockwise[i] = true;
      }
    }
    // store previous distance
    distance[i] = dist;
  }

  points.draw();  
}


