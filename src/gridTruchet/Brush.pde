class Brush {
  float x; // x position
  float y; // y position
  float w; // width
  float h; // height
  int p; // pattern

  Brush(float _x, float _y, float _w, float _h, int _p) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
  }

  void draw() {
    switch(p) {
    case 1:
      arc(x, y, w, h, 0, HALF_PI);
      arc(x+w, y+h, w, h, PI, PI+HALF_PI);
      break;
    default:
      arc(x+w, y, w, h, HALF_PI, PI);
      arc(x, y+h, w, h, PI+HALF_PI, TWO_PI);
      break;
    }
  }
}
