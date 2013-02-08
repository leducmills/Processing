// creates fake horses when needed for testing
void makeFakes() {
  int numSimHorses = 15;

  for (int i=1; i<numSimHorses+1; i++) {
    println("fake horse " + i);
    int simID = i;
    makeHorse(simID, i); // make a simulated horse
  }
}

