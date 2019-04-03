void setup() {
  size(400, 400);
  background(255);
  strokeWeight(1);
  noLoop();
}

void draw() {
  PVector _a = new PVector(0, 0);
  PVector _b = new PVector(width, 0);
  PVector _c = new PVector(0, height);
  PVector _d = new PVector(width, height);
  drawTriangle(_a, _b, _c, 5);
  //drawTriangle(_b, _c, _d, 5);
}

void drawTriangle(PVector a, PVector b, PVector c, int depth) {
  pushMatrix();
  println(a.x, a.y, b.x, b.y, c.x, c.y);

  // setup
  float distortion = random(0.3, 0.7);  
  PVector d = b.copy();
  d.add(c);
  d.mult(distortion);

  // draw
  translate(a.x, a.y);
  line(a.x, a.y, b.x, b.y);
  line(b.x, b.y, c.x, c.y);
  line(c.x, c.y, a.x, a.y);
  line(d.x, d.y, a.x, a.y);

  popMatrix();
  
  // iterate
  if (depth > 1) {
    depth--;
    drawTriangle(a, d, c, depth);
  }
}
