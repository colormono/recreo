// Hexagon Calculator
// https://hexagoncalculator.apphb.com/

import Turtle.*;
Turtle t;

void setup() {
  size(600, 600);
  background(255);
  stroke(0);
  noLoop();

  t = new Turtle(this);
}

void draw() {
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);

  // apothem = s / 2tan(180/n)
  // where s = side length && n = no. of sides
  int s = 100;
  int n = 6;
  float apothem = s / (2 * tan(radians(180/n)));
  println(apothem);

  // side to side
  float s2s = apothem*2;

  // vertex to vertex
  float v2v = s*2;

  for (int x=0; x<6; x++) {
    t.penUp();  
    t.goToPoint(100, 100);
    t.penDown();
    t.right(90);
    t.forward(s);
    t.right(45);
    t.back(apothem);
  }

  for (int x=0; x<width; x+=s2s) {
    for (int y=0; y<height; y+=v2v) {
      stroke(random(255), random(255), random(255));
      ellipse(x, y, 10, 10);
      t.penUp();
      t.goToPoint(x, y);
      t.penDown();
      polygon(s, n);
    }
  }

  //t.drawTurtle();
}

void hexagon(float sideLength) {
  for (int i=0; i<6; i++) {
    t.forward(sideLength);
    t.right(60);
  }
}

void polygon(float sideLength, int numberOfSides) {
  for (int i=0; i<numberOfSides; i++) {
    t.forward(sideLength);
    t.right(360/numberOfSides);
  }
}
