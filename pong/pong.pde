// Collision (Pong)
// by REAS <http://reas.com>

// Move the mouse up and down to move the paddle. 

// Updated 13 January 2003 by K Pfeiffer


// Global variables for the ball
float ball_x;
float ball_y;
float ball_dir = 1;
float ball_size = 5;  // Radius
float dy = 0;  // Direction

// Global variables for the paddle
int paddle_width = 5;
int paddle_height = 20;

int dist_wall = 15;

void setup()
{
 size(200, 200);
 rectMode(CENTER);
 ellipseMode(CENTER);
 noStroke();
 ball_y = height/2;
 ball_x = 1;
 frameRate(30);
}

void draw() 
{
 background(51);
 
 ball_x += ball_dir * 2;
 ball_y += dy;
 if(ball_x < -ball_size) { //<<<<<<<<<<<<1
   ball_x = width+ball_size;
   ball_y = random(0, height);
   dy = 0;
 }
 
 // Constrain paddle to screen
 float paddle_y = constrain(mouseY, paddle_height, height-paddle_height);

 // Test to see if the ball is touching the paddle
 float py = dist_wall+paddle_width+ball_size; //<<<<<<<<<<<<2
 if(ball_x == py 
    && ball_y > paddle_y - paddle_height - ball_size 
    && ball_y < paddle_y + paddle_height + ball_size) {
   ball_dir *= -1;
   if(mouseY != pmouseY) {
     dy = (mouseY-pmouseY)/2.0;
     if(dy >  5) { dy =  5; }
     if(dy < -5) { dy = -5; }
   }
 } 
 
 // If ball hits paddle or back wall, reverse direction
 if((ball_x > 200-ball_size) && ball_dir == 1) { //<<<<<<<<<<<<3
   ball_dir *= -1;
 }
 
 // If the ball is touching top or bottom edge, reverse direction
 if(ball_y > height-ball_size) {
   dy = dy * -1;
 }
 if(ball_y < ball_size) {
   dy = dy * -1;
 }

 // Draw ball
 fill(255);
 ellipse(ball_x, ball_y, ball_size, ball_size);
 
 // Draw the paddle
 fill(153);
 rect(dist_wall, paddle_y, paddle_width, paddle_height); //<<<<<<<<<<<<4
}
