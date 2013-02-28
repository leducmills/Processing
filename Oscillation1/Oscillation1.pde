

void setup() {
 size(640, 360); 
}


void draw() {
  


float amplitude = 100; //  greatest distance from center of movement - measured in pixels
float period = 120;  // time of one cycle, measured in frames

float x = amplitude * cos(TWO_PI * frameCount / period);

stroke(0);
fill(175);
translate(width/2, height/2);
line(0,0,x,0);
ellipse(x,0,20,20);

}
