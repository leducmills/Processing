import rad._
import pso._
import lsys._
import oog._
import anar._
import voronoi._
import processing.opengl._



var myObj = new Obj()


def setup() {
  size(800, 400, OPENGL)
  //Anar.init(this);

  initForm()
}


def initForm() {
  //Create a new Object to store our shape
  println("yes!")
  
  //myObj = new Obj()

  //Create few points with absolute coordinates
  var a = Anar.Pt(-60, -60)
  var b = Anar.Pt(60, -60)
  var c = Anar.Pt(60, 60)
  var d = Anar.Pt(-60, 60)

  //Create a new Face
  var mySquare = new Face
  
  //Store the points inside our Face
  mySquare.add(a)
  mySquare.add(b)
  mySquare.add(c)	
  mySquare.add(d)
  
  //Store mySquare in our object
  myObj.add(mySquare)

  //Create Sliders based on an object
  //Anar.sliders(myObj)
}


def draw() {
  background(150)
  myObj.draw()
}
