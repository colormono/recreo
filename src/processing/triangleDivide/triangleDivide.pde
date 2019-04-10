boolean canDraw = true;

void setup() {
  size(400, 400);
  background(255);
  strokeWeight(1);
}

void draw() {
  if (canDraw) {
    generate();
    canDraw = false;
  }
}

void generate() {
  background(255);
  PVector _a = new PVector(0, 0);
  PVector _b = new PVector(width, 0);
  PVector _c = new PVector(0, height);
  PVector _d = new PVector(width, height);
  drawTriangle(_a, _b, _c, 5);
  //drawTriangle(_b, _c, _d, 5);
}

void drawTriangle(PVector a, PVector b, PVector c, int depth) {
  //println(a.x, a.y, b.x, b.y, c.x, c.y);
  stroke(random(255), random(255), random(255));

  pushMatrix();
  //translate(a.x, a.y);
  line(a.x, a.y, b.x, b.y);
  line(b.x, b.y, c.x, c.y);
  line(c.x, c.y, a.x, a.y);
  popMatrix();

  // iterate
  if (depth > 1) {
    depth--;

    // Get Largest segment
    int ls = getLargestSide(a, b, c);
    if (ls == 1) {
      println("distAB is the largest");
      PVector d = getD(a, b);
      drawTriangle(a, d, c, depth);
      drawTriangle(b, d, c, depth);
    } else if (ls == 2) {
      println("distAC is the largest");
      PVector d = getD(a, c);
      drawTriangle(a, d, b, depth);
      drawTriangle(c, d, b, depth);
    } else {
      println("distBC is the largest");
      PVector d = getD(b, c);
      drawTriangle(b, d, a, depth);
      drawTriangle(c, d, a, depth);
    }
  }
}

int getLargestSide(PVector a, PVector b, PVector c) {
  float distAB = a.dist(b);
  float distBC = b.dist(c);
  float distAC = a.dist(c);

  if (distAB >= distBC) {
    if (distAB >= distAC) {
      return 1;
    } else {
      return 2;
    }
  } else if (distBC >= distAC) {
    return 3;
  }
  return 2;
}

PVector getD(PVector a, PVector b) {
  float distortion = random(0.3, 0.7);  
  a.sub(b);
  a.mult(distortion);
  return a;
}

void mouseClicked() {
  canDraw = true;
}
