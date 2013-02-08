import processing.opengl.*;
import anar.*;


Obj myObj;

void setup(){
    size(800,400,OPENGL);
  Anar.init(this);
  Anar.drawAxis();

  initForm();
}

void initForm(){
  myObj = new Obj();
  
  Face pts = new Face();
  
  pts.add(Pt.rnd(100,100));
  pts.add(Pt.rnd(100,100));
  pts.add(Pt.rnd(100,100));
  myObj.add(pts);
  
  Pt center = new PtBary(pts);
  center.fill(255,0,0);
  myObj.add(center);
  
  Anar.camTarget(myObj);
  
  Pt circumcenter = circumCenter(pts);
  circumcenter.fill(0,0,255);
  myObj.add(circumcenter);    
  
  Face circle = new Circle(circumcenter,circumRadius(pts),100);
  myObj.add(circle);
}

//http://en.wikipedia.org/wiki/Circumcircle
Pt circumCenter(Face f){
  
  Vertex p1 =  new Vertex(f.pt(0));
  Vertex p2 =  new Vertex(f.pt(1));
  Vertex p3 =  new Vertex(f.pt(2));
  
  float aLen = p2.lengthSq(p3);
  float bLen = p1.lengthSq(p3);
  float cLen = p1.lengthSq(p2);
  
  float sub = 2 * Vertex.cross(p1.minus(p2),p2.minus(p3)).lengthSq(); 
  
  float a = aLen*Vertex.dot(p1.minus(p2),p1.minus(p3))/sub;
  float b = bLen*Vertex.dot(p2.minus(p1),p2.minus(p3))/sub;
  float c = cLen*Vertex.dot(p3.minus(p1),p3.minus(p2))/sub;
  
  //Override!!! Please Java Engineers, Help me to override this!!!
  //    p1*a + p2*b + p3*c
  Vertex result = (Vertex)p1.multiply(a).plus(p2.multiply(b)).plus(p3.multiply(c));
  
  return Anar.Pt(result);
}

//http://en.wikipedia.org/wiki/Circumcircle
float circumRadius(Face f){
  
  float totalLength;
  
  //Isit general for polyfgons?
  totalLength  = f.pt(0).length(f.pt(1));
  totalLength *= f.pt(1).length(f.pt(2));
  totalLength *= f.pt(2).length(f.pt(0));
  
  float area = f.area();
  
  println("AREA:"+(float)area);
  println("Triangle Permieter:"+(float)totalLength);
  
  return totalLength/(4*area);
}


void draw(){
  background(155);
  myObj.draw();
}

void keyPressed(){
  if (key==' ') initForm();
}

