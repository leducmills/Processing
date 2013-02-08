
String inString;
String oldString;

void setup() {
  inString = "hello";
  oldString = inString;
}

void draw () {
  if (oldString != inString) {
  println(inString);
  }
  
}

void keyPressed() {
 
  if(key == 'n') {
   
   inString = "goodbye";
    
  }
 
  
}

