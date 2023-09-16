class Brush {
  int p; // pattern
  float x; // x position
  float y; // y position
  float w; // width
  float h; // height
  boolean mirror;

  Brush(int _p, float _x, float _y, float _w, float _h, boolean _mirror) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    mirror = _mirror;
  }

  // draw using the stroke weight of the layer to fill
  void draw(float fill) {
    switch(p) {
    case 0:
      drawLine();
      break;
    case 1:
      drawWrongLine(true, 6);
      break;
    }
  }

  void drawLine() {
    if (!mirror) {
      line(x, y, x+w, y+h);
    } else {
      line(x+w, y, x, y+h);
    }
  }

  void drawWrongLine(boolean mirror, int steps) {
    if (!mirror) {
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
    } else {
      float currentX = x+w;
      float currentY = y;
      float nextX = x+w;
      float nextY = y;
      float finalX = x;
      float finalY = y+h;

      for (int i=0; i<steps; i++) {
        line(currentX, currentY, nextX, nextY);
        currentX = nextX;
        currentY = nextY;
        nextX = nextX - random(0, w/steps);
        nextY = nextY - random(0, h/steps);
      }
      line(currentX, currentY, finalX, finalY);
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

  void drawSpiral() {
    int steps = 12;
    float r = 0;
    float theta = 0;
    float px = 0;
    float py = 0;

    for (int i=0; i<steps; i++) {
      // Polar to Cartesian conversion
      float nx = r * cos(theta);
      float ny = r * sin(theta);

      // Draw an ellipse at x,y
      // Adjust for center of window
      line(x+px, y+py, x+nx, y+ny); 
      fill(0, 0, 255);

      // Increment the angle
      theta += 0.6;

      // Increment the radius
      r += 0.4;

      // update positions
      px = nx;
      py = ny;
    }
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
