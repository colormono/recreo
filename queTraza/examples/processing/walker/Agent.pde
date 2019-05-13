class Agent {
  PVector pos;
  PVector prev;

  Agent(float _x, float _y) {
    pos = new PVector(_x, _y);
    prev = new PVector(_x, _y);
  }

  void walk() {
    PVector step = PVector.random2D();
    float r = random(100);
    if (r<5) {
      step.mult(random(10, 25));
    } else {
      step.setMag(2);
    }
    pos.add(step);
  }

  void draw() {
    strokeWeight(1);
    stroke(0);
    line(pos.x, pos.y, prev.x, prev.y);
    prev = pos.copy();
  }
}
