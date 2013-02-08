ArrayList vertices, edges;
int numOfVertex = 100;

void setup()
{
  size(600, 500);
  background(0);
  stroke(255, 255, 255, 45);
  strokeWeight(2);
  fill(255, 255, 255, 100);
  vertices = new ArrayList();
  edges = new ArrayList();

  for(int i = 0; i < numOfVertex; i++)
  {
    vertices.add(new Vertex(random(width), random(height))); //add the random vertices
    Vertex v = (Vertex) vertices.get(i);
    ellipse(v.x, v.y, 4, 4);					    //draw it to the screen
  }
  buildEdges();
  drawEdges();
}

void buildEdges()
{
  int currentVertex = 0;
  while(currentVertex < numOfVertex)    //first measure n weights, then n-1 weights and so on.
  {
    for(int i = currentVertex; i < numOfVertex-1; i++)
    {
	edges.add(new Edge((Vertex)vertices.get(currentVertex), (Vertex)vertices.get(i+1)));
    }
    currentVertex++;
  }
  Collections.sort(edges);		  //sort the edges so edges with smaller weights are first
}

void drawEdges()
{
  for(int i = 0; i < numOfVertex; i++)  //draw edges
  {
    Edge e = (Edge)edges.get(i);
    line(e.start.x, e.start.y, e.end.x, e.end.y);
  }
}
