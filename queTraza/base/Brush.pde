class Brush {
  int p; // pattern
  float x; // x position
  float y; // y position
  float w; // width
  float h; // height

  Brush(int _p, float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
  }

  // draw using the stroke weight of the layer to fill
  void draw(float fill) {
    switch(p) {
    case 0:
      drawSquare(fill);
      break;
    case 1:
      drawWrongLine(6);
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

  void drawWrongLine(int steps) {
    float currentX = x;
    float currentY = y;
    float nextX = x;
    float nextY = y;
    float finalX = x+w;
    float finalY = y+h;

    for (int i=0; i<steps; i++) {
      line(currentX, currentY, nextX, nextY);
      currentX = nextX;
      currentY = nextY;
      nextX = nextX + random(0, w/steps);
      nextY = nextY + random(0, h/steps);
    }
    line(currentX, currentY, finalX, finalY);
  }

  void drawX() {
    line(x, y, x+w, y+h);
    line(x+w, y, x, y+h);
  }

  void drawCircle() {
    ellipseMode(CORNER);
    ellipse(x, y, w, h);
  }

  void drawSquare(float fill) {
    rectMode(CORNER);
    if (fill > 0) {
      for (float i=0; i<=h; i+=fill) {
        line(x, y+i, x+w, y+i);
      }
    } else {
      rect(x, y, w, h);
    }
  }
}
