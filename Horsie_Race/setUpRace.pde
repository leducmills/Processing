// get ready for racing
void setUpRace() {
  //horses at gate
  player = minim.loadFile(horseRace.startingClip);

  if(!setUpR) { // if we haven't played the starting sound
    //play long clip
    player.play(6500); // pass the argument (6000) to shorten the clip for testing
    setUpR=true;
  }
  if(!gameOver) {
    msg=""; // blank the message
  }
 
}
