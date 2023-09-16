class Bloque {
  PVector pos;
  float w, h;
  int density;
  float angle, speed;
  color c;

  Bloque(int _x, int _y, float _w, float _h, int _density, color _color, float _angle, float _speed) {
    pos = new PVector(_x, _y);
    w = _w;
    h = _h;
    density = _density;
    angle = _angle;
    speed = _speed;
    c = _color;
  }

  void draw() {
    stroke(c);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(angle));
    translate(-width/2 + pos.x, -height/2 + pos.y);
    for (int y=0; y<h; y+=density) {
      line(0, y, w, y);
    }    
    popMatrix();
  }

  void move() {
  }
}
