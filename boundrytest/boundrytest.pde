int currentx = 0;
int currenty = 0;

int max_x = 100;
int max_y = 100;



void setup() {
  
}

void draw() {

  int movex = random(1, 50);
  int movey = random(1, 50);

  
  if(currentx + movex < max_x){
    currentx += movex;
     
  }
  
  if(currenty + movey < max_y){
    currenty += movey; 
  }
  
}
