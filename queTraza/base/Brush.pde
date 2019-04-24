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
    case 0:
      drawWrongLine();
      break;
    case 1:
      drawCircle();
      break;
    }
  }

  void drawLine(boolean mirror) {
    if (!mirror) {
      line(x, y, x+w, y+h);
    } else {
      line(x+w, y, x, y+h);
    }
  }
  
  void drawX() {
    line(x, y, x+w, y+h);
    line(x+w, y, x, y+h);
  }
  
  void drawCircle() {
    ellipseMode(CORNER);
    ellipse(x, y, w, h);
  }
  
  void drawWrongLine(){
    float r = random(-2, 2);
    line(x+r, y+r, x+w+r, y+h+r);
  }
}
