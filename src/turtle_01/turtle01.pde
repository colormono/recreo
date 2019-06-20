import Turtle.*;
Turtle t;

void setup() {
  size(500, 500);
  pixelDensity(2);

  background(255);
  stroke(0);
  strokeWeight(0.4);

  t = new Turtle(this);
  noLoop();
}

void draw () {
  int i=0;
  t.penUp();
  t.goToPoint(200, 375);
  t.penDown();

  while (i<800) {
    t.forward(300);
    t.right(144.9);
    i ++;
  }
}
