class Pattern {
  PVector position;
  float size;
  int layer;

  Pattern(PGraphics pg, int _layer, int _x, int _y, float _size) {
    layer = _layer;
    position = new PVector(_x, _y);
    size = _size;
  }

  void drawPattern(int id) {
    //boolean mirror = (random(100) > 50) ? true : false;

    pg.pushMatrix();
    pg.translate(position.x, position.y);
    switch(id) {
    case 0:
      pattern03(false);
      break;
    case 1:
      pattern01();
      break;
    case 2:
      pattern02();
      break;
    case 3:
      pattern03(true);
      break;
    default:
      pattern0();
    }
    pg.popMatrix();
  }

  void pattern0() {
    // Sólido formado por líneas 
    pg.stroke(0);
    int d = 4;
    for (int y = 0; y <= size; y+= d) {
      pg.line(0, y, size, y);
    }
  }

  void pattern01() {
    // Cuadrado formado por líneas horizontales
    // separadas por una distancia definida
    pg.stroke(255,255,0);
    int d = 4;
    for (int y = 0; y <= size; y+= d) {
      pg.line(0, y, size, y);
    }
  }

  void pattern02() {
    // Cuadrado formado por líneas verticales
    // separadas por una distancia definida
    pg.stroke(0);
    int d = 4;
    for (int x = 0; x <= size; x+= d) {
      pg.line(x, 0, x, size);
    }
  }

  void pattern03(boolean mirror) {
    // Cuadrado formado por líneas verticales
    // separadas por una distancia definida
    // se puede espejar
    pg.stroke(255,0,0);
    int d = 4;
    if (mirror) {
      pg.pushMatrix();
      pg.translate(size, 0);
      pg.scale(-1, 1);
      pg.stroke(0,0,255);
    }
    for (int x=0; x<=size; x+=d) {
      pg.line(x, 0, size, size-x);
    }
    for (int y=d; y<=size; y+=d) {
      pg.line(0, y, size-y, size);
    }
    if (mirror) {
      pg.popMatrix();
    }
  }
}
