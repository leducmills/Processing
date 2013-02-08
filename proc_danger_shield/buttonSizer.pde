void buttonSizer(int button1, int button2, int button3) {
 
  if (button1 == 0) {
    
    x++;
    
  }
  if (button2 == 0) {
    y++;
  }
  if (button3 == 0) {
    x--;
    y--;
  }
  
  println("x " +  x);
  println("y "  + y);
  
}
