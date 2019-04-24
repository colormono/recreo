int x;
int y;
float outsideRadius = 150;
float insideRadius = 100;

void setup() {
  size(640, 640);
  background(255);
  noFill();
  noLoop();
}

void draw() {
  background(204);
  PVector _a = new PVector(0, 0);
  PVector _b = new PVector(width, 0);
  PVector _c = new PVector(0, height);

  beginShape(TRIANGLE_STRIP); 
  drawTriangle(_a, _b, _c, 5);
  endShape();
}

void drawTriangle(PVector a, PVector b, PVector c, int depth) {
  vertex(a.x, a.y);
  vertex(b.x, b.y);
  vertex(c.x, c.y);

  // Get Largest segment
  float distAB = dist(a.x, a.y, b.x, b.y);
  float distBC = dist(b.x, b.y, c.x, c.y);
  float distAC = dist(a.x, a.y, c.x, c.y);
  
  PVector d;
  
  if (distAB >= distBC) {
    if (distAB >= distAC) {
      println("distAB is the largest");
      d = getD(a, b);
    } else {
      println("distAC is the largest");
      d = getD(a, c);
    }
  } else if (distBC >= distAC) {
    println("distBC is the largest");
    d = getD(b, c);
  } else {
    println("distAC is the largest");
    d = getD(a, c);
  }

  vertex(d.x, d.y);
}

PVector getD(PVector a, PVector b) {
  float distortion = 0.5;  
  PVector d = new PVector((a.x + b.x)*distortion, (a.y + b.y)*distortion);
  println(d.x, d.y);
  return d;
}
