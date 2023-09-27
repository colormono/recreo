class Estrella {
  PVector location, speed;
  int radius;
  int hitZone;

  Estrella(float _x, float _y) {
    location = new PVector(_x, _y);
    speed = new PVector(random(-1, 1), random(-1, 1));
    radius = 4;
    hitZone = 20;
  }

  void move() {
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
    location.x = location.x + speed.x;

    if (location.y < 0) location.y = height;
    if (location.y > height) location.y = 0;
    location.y = location.y + speed.y;
  }

  void draw() {
    rect(location.x, location.y, radius, radius);
    rect(location.x, location.y-radius, radius, radius);
    rect(location.x, location.y+radius, radius, radius);
    rect(location.x-radius, location.y, radius, radius);
    rect(location.x+radius, location.y, radius, radius);
  }

  void connect(PVector with) {
    float d = dist(location.x, location.y, with.x, with.y);
    if (d < hitZone) {
      line(location.x, location.y, with.x, with.y);
    }
  }
}
