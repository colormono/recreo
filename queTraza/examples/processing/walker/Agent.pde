class Agent {
  PVector pos;
  PVector prev;

  Agent(float _x, float _y) {
    pos = new PVector(_x, _y);
    prev = new PVector(_x, _y);
  }

  void walk() {
    PVector step = PVector.random2D();
    float r = random(80);
    if (r<5) {
      step.mult(random(10, 25));
    } else {
      step.setMag(2);
    }
    pos.add(step);
  }

  float getPixelBright(float x, float y) {
    int px = int(map(x, 0, width, 0, placeholder.width));
    int py = int(map(y, 0, height, 0, placeholder.height));
    return brightness(placeholder.get(px, py));
  }

  void draw() {
    line(pos.x, pos.y, prev.x, prev.y);
    prev = pos.copy();
  }
}
