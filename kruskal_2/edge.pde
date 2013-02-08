class Edge implements Comparable{
  //Edges consists of a start Vertex, end Vertex and a weight
  public Vertex start;
  public Vertex end;
  public float weight;  

  Edge(Vertex s, Vertex e)
  {
    start = s;
    end = e;
    weight = dist(s.x, s.y, e.x, e.y);
  }
  
  public int compareTo(Object edge) //overrides compareTo so I can use Collections to sort the edges
  {  
    Edge n = (Edge) edge;  
    float w1 = weight;
    float w2 = n.getWeight();  
    return w1 == w2 ? 0 : (w1 > w2 ? 1 : -1);  
  }
  
  public float getWeight()
  {
    return weight;
  } 
}
