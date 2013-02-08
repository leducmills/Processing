import processing.opengl.*;
import anar.*;


Obj myObj = new Obj();

void setup(){
    size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();
  initForm();
}

void initForm(){

  int n = 6; // number of elements in X
  int m = 6; // number of elements in Y

  Param axonometric = new Param(0,0,50);
  TranslateZ tz = new TranslateZ(axonometric);

  Obj grid = createGrid(n,m);
  myObj.add(grid);

  Obj ctrlX = createCtrlInX(n,m,grid);
  ctrlX.apply(tz);
  myObj.add(ctrlX);

  Obj curvesX = ptsSetToCurves(ctrlX,50);
  curvesX.apply(tz);
  curvesX.apply(tz);
  myObj.add(curvesX);

  Obj ctrlY = createCtrlInY(curvesX,50);
  ctrlY.apply(tz);
  ctrlY.apply(tz);
  ctrlY.apply(tz);
  myObj.add(ctrlY);

  Obj curvesY = ptsSetToCurves(ctrlY,50);
  curvesY.apply(tz);
  curvesY.apply(tz);
  curvesY.apply(tz);
  curvesY.apply(tz);
  myObj.add(curvesY);
  
  
  Obj faces = createFacesFromAGrid(curvesY);
  faces.apply(tz);
  faces.apply(tz);
  faces.apply(tz);
  faces.apply(tz);  
  faces.apply(tz); 
  myObj.add(faces);

  // Anar.sliders(myObj)
  Anar.sliders(tz);
  Anar.camTarget(myObj);
}



Obj createGrid(int n, int m){
  Obj output = new Obj();

  for (int i = 0; i<n; i++)
    for (int j = 0; j<m; j++){
      // Create a list of point
      // This is our Vertical lines
      Pts vertical = new Pts();

      // Create a first point on the floor
      Pt ori = Anar.Pt(i*30,j*60);
      vertical.add(ori);

      // Derive a second point from the previous position
      TranslateZ tz = new TranslateZ(random(50)+30);
      if( (i*n+j)%12==0)
        Anar.sliders(tz);

      Pt up = Anar.Pt(ori,tz);
      vertical.add(up);

      // Store the lines in our output
      output.add(vertical);
    }

  return output;
}


Obj createCtrlInX(int n, int m, Obj grid){
  // Link the upper points together
  Obj allCtrlLineX = new Obj();

  for (int i = 0; i<n; i++){
    Pts ctrlLineX = new Pts();
    for (int j = 0; j<m; j++)
      ctrlLineX.add(grid.line(i+ (j*n)).pt(1));

    ctrlLineX.stroke(155,0,0);
    allCtrlLineX.add(ctrlLineX);
  }

  return allCtrlLineX;
}


Obj ptsSetToCurves(Obj ctrlX, int nPts){
  // Link the upper points together
  Obj curves = new Obj();

  for (int i = 0; i<ctrlX.numOfLines(); i++)
    curves.add(createCurve(ctrlX.line(i),nPts));

  return curves;
}



Pts createCurve(Pts construction, int nPts){

  // From this first set of points, create a curve of degree 4
  CSpline curve = new CSpline(construction,4);

  // Extract a serie of points from the curve
  Pts curveWithPointsUniform = curve.getPts(nPts);
  curveWithPointsUniform.stroke(155,155,255);

  return curveWithPointsUniform;
}


Obj createCtrlInY(Obj grid, int nPts){
  // Link the upper points together
  Obj allCtrlLineY = new Obj();

  for (int i = 0; i<grid.line(0).numOfPts(); i++){
    Pts ctrlLineY = new Pts();
    for (int j = 0; j<grid.numOfLines(); j++)
      ctrlLineY.add(grid.line(j).pt(i));

    ctrlLineY.stroke(200,0,0);
    allCtrlLineY.add(ctrlLineY);
  }

  return allCtrlLineY;
}


Obj createFacesFromAGrid(Obj grid){
  Obj output = new Obj();
  
  for (int i = 1; i<grid.numOfLines(); i++)
    for (int j = 1; j<grid.line(i).numOfPts(); j++)
    {
      Face f = new Face();
      
      f.add(grid.line(i-1).pt(j-1));
      f.add(grid.line(i-1).pt(j));
      f.add(grid.line(i).pt(j));
      f.add(grid.line(i).pt(j-1));
      
      output.add(f);
    }

  
  return output;
}


void draw(){
  background(155);
  myObj.draw();
}



