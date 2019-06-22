class Brush {
  float x; // x position
  float y; // y position
  float w; // width
  float h; // height
  int p; // pattern
  boolean mirror;

  // pattnerns counter
  int brushPatterns = 6;

  Brush(float _x, float _y, float _w, float _h, int _p) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    mirror = (random(100) > 50) ? true : false;
  }

  void nextPattern() {
    if (p < brushPatterns) {
      p += 1;
    } else {
      p = 0;
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    switch(p) {
    case 0:
      pattern0();
      break;
    case 1:
      pattern01();
      break;
    case 2:
      pattern02();
      break;
    case 3:
      pattern03(mirror);
      break;
    case 4:
      pattern04(mirror);
      break;
    case 5:
      pattern05(mirror);
      break;
    default:
      // silence
    }
    popMatrix();
  }


  void pattern0() {
    // Sólido formado por líneas
    int d = 1;
    for (int _y = 0; _y <= h; _y+= d) {
      line(0, _y, w, _y);
    }
  }

  void pattern01() {
    // Cuadrado formado por líneas horizontales
    // separadas por una distancia arbitraria
    int d = 4;
    for (int _y = 0; _y <= h; _y+= d) {
      line(0, _y, w, _y);
    }
  }

  void pattern02() {
    // Cuadrado formado por líneas verticales
    // separadas por una distancia definida
    int d = 4;
    for (int _x = 0; _x <= w; _x+= d) {
      line(_x, 0, _x, h);
    }
  }

  void pattern03(boolean mirror) {
    // Cuadrado formado por líneas verticales
    // separadas por una distancia definida
    // se puede espejar
    int d = 4;
    if (mirror) {
      pushMatrix();
      translate(w, 0);
      scale(-1, 1);
    }
    for (int _x=0; _x<=w; _x+=d) {
      line(_x, 0, w, w-_x);
    }
    for (int _y=d; _y<=h; _y+=d) {
      line(0, _y, h-_y, h);
    }
    if (mirror) {
      popMatrix();
    }
  }

  void pattern04(boolean mirror) {
    // Pintar una mitad verticalmente
    // se puede espejar
    int d = 1;
    if (mirror) {
      pushMatrix();
      translate(w, 0);
      scale(-1, 1);
    }
    for (int _x=0; _x<=w; _x+=d) {
      line(_x, 0, w, w-_x);
    }
    if (mirror) {
      popMatrix();
    }
  }

  void pattern05(boolean mirror) {
    // Pintar una mitad verticalmente
    // se puede espejar
    int d = 1;
    if (mirror) {
      pushMatrix();
      translate(w, 0);
      scale(-1, 1);
    }
    for (int _y=d; _y<=h; _y+=d) {
      line(0, _y, h-_y, h);
    }
    if (mirror) {
      popMatrix();
    }
  }
}
