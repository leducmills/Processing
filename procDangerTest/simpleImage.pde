 void simpleImage(int backgnd) {
 
 if(backgnd == 1) {
   image(img01, 0, 0, width, height);
 }
 
 if(backgnd == 2) {
   image(img02, 0, 0, width, height); 
 }
 
 if(backgnd == 3) {
   image(img03, 0, 0, width, height); 
 }
   
 //image(img03, 0, 0, width, height);
 point(100, 200);
 line(10, 10, 500, 300);
 noStroke();
 fill(200, 0, 200, 100);
 triangle(100, 200, 250, 150, 350, 200);
 stroke(1);
 strokeWeight(1); 
 fill(255, 0, 0);
 rect(50, 50, 100, 100);
 ellipse(600, 100, 50, 50);
 }
