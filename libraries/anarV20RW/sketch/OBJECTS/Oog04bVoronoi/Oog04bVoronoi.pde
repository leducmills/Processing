import processing.opengl.*;
import anar.*;


import java.util.ArrayList;
import java.util.Iterator;




Obj myObj;

void setup(){
    size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  myObj = new Obj();

  // RANDOMS POINTS
  Obj inPts = new Obj();
  for (int i = 0; i<200; i++)
    inPts.add(Pt.rnd(400,400));
  
  myObj.add(inPts);


  // INIT THE TRIANGULATION
  int sz = 1000000;

  Simplex firstTriangle = new Simplex(new Pnt[]{new Pnt( -sz, -sz), new Pnt(sz, -sz), new Pnt(0,sz)});
  DelaunayTriangulation dt = new DelaunayTriangulation(firstTriangle);

  // ADD THE POINTS
  for (int i = 0; i<inPts.numOfPts(); i++)
    dt.delaunayPlace(new Pnt(inPts.pt(i).x(),inPts.pt(i).y()));


  // RETURN EDGES
  Pts allPts = new Pts();

  ArrayList simplexComparator = new ArrayList();

  for (Iterator it = dt.iterator(); it.hasNext();){

    Simplex triangle = (Simplex)it.next();

    for (Iterator otherIt = dt.neighbors(triangle).iterator(); otherIt.hasNext();){

      Simplex other = (Simplex)otherIt.next();

      // CHECK IF ALREADY IN THE LIST
      Simplex[] ss = new Simplex[2];
      ss[0] = triangle;
      ss[1] = other;

      if( !isInList(simplexComparator,ss)){

        // ADD REVERSED TO THE LIST
        Simplex[] ss2 = new Simplex[2];
        ss2[0] = other;
        ss2[1] = triangle;
        simplexComparator.add(ss);
        simplexComparator.add(ss2);

        Pnt p = Pnt.circumcenter((Pnt[])triangle.toArray(new Pnt[0]));
        Pnt q = Pnt.circumcenter((Pnt[])other.toArray(new Pnt[0]));

        Pts connex = new Pts();
        connex.add(filterPts(allPts,p.coord(0),p.coord(1)));
        connex.add(filterPts(allPts,q.coord(0),q.coord(1)));

        myObj.add(connex);
      }

    }
  }
  
}


//COMPARE SETS OF SIMPLEXS
boolean isInList(ArrayList arr, Simplex[] ss){
  boolean out = false;

  for (int i = 0; i<arr.size(); i++){
    Simplex[] sss = (Simplex[])arr.get(i);
    if(sss[0]==ss[0]&&sss[1]==ss[1]){
      out = true;
    }
  }
  return out;
}


//MAINTAIN A LIST OF UNIQUE POINTS
Pt filterPts(Pts pts, float x, float y){
  Pt out = Anar.Pt(x,y);

  for (int i = 0; i<pts.size(); i++){
    Pt q = pts.pt(i);

    if(Math.abs(q.x()-x)<0.0001&&Math.abs(q.y()-y)<0.0001)
      out = q;
  }

  return out;
}


void draw(){
  background(255);
  myObj.draw();
}

void keyPressed(){
  if(key==' ')
    initForm();
}

