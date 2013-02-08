//Class for color boxes (takes R,G,B values from 3 different sensors)

class ColorBox {

  int sizeX, sizeY, posX, posY;
  float value1, value2, value3;
  String address;
  boolean victory;

  ColorBox(String _address, int _sizeX, int _sizeY, int _posX, int _posY) { //initialize ColorBox object

    address = _address;
    sizeX = _sizeX;
    sizeY = _sizeY;
    posX = _posX;
    posY = _posY;
  }


  void render() {

    noStroke();
    //fill(value1, value2);
    fill(value1, value2, value3);
    rect(posX, posY, sizeX, sizeY);

    textAlign(LEFT);
    fill(0);
    textSize(10);

    text(address, posX, posY + sizeY + 10);

    if (victory == true) {

      textSize(20);
      text(" WINS!!!", posX, posY+20);
    }
  }
}

