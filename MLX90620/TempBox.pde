class TempBox {

  int x, y;
  color c;
  int size = 65;

  TempBox(int _x, int _y, color _c) {

    x = _x;
    y = _y;
    c = _c;
  }

  void update(float sensorVal) {

    //adjust the second and third values of the map() function to the expected temperature range for the best results
    sensorVal = map(sensorVal, 32, 100, 255, 0);
    c = color(sensorVal, 200, 150);
  }

  void display() {

    noStroke();
    fill(c);
    rect(x, y, size, size);
  }
}

