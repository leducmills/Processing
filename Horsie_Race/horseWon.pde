// handles the game over state
void horseWon(int horse, String clip, String message) { // accepts the horse ID, a sound and a message
  if(gameOver) { // if the game has ended
    msg=message; // load the winning message
    player2 = minim.loadFile(clip); // load the sound
    player2.play(); // play the sound
  }
  // restart the game
  setUpRace();
  gameOver=false; 
  startRace=true;
  minim.stop(); // unload mimim 
  msg=message+"!\nPress \"S\" to start new race";
}

