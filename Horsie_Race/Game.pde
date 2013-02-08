// creates a game object
class Game {
  String startingClip; // sound to play when game starts
  String cheer; // sound to play when game ends
  String trot; // sound to play when advancing a horse
  int bg; // background color

  Game( int c, String startingSong, String cheer, String trot) { // game accepts a background color, start sound and end sound
    startingClip=startingSong;
    this.cheer=cheer;
    this.trot=trot;
    bg=c;
  }
}

