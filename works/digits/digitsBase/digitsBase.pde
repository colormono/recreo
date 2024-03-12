boolean newDraw = true;

int mt = 40;
int mr = 8;
int mb = 8;
int ml = 50;

int w = 10;
int h = 20;

void setup() {
  size(500, 700);
  stroke(255);
  strokeWeight(1);
}

void draw() {
  if (newDraw) {
    background(0);

    int rows = 22;
    int cols = 22;
    int total = rows * cols;
    int counter = 0;

    for (int y=0; y<rows; y++) {
      for (int x=0; x<cols; x++) {
        int chance = (int) map(counter, 0, total, 100, 1);
        drawDigit(x*w+ml+(mr*x), y*h+mt+(mb*y), chance);

        counter ++;
      }
    }
    newDraw = false;
  }
}

void drawDigit(float x, float y, int chance) {
  //20x40

  push();
  translate(x, y);

  // horizontales
  if (random(100) < chance) line(0, 0, w, 0);
  if (random(100) < chance) line(0, h/2, w, h/2);
  if (random(100) < chance) line(0, h, w, h);

  // verticales
  if (random(100) < chance) line(0, 0, 0, h/2);
  if (random(100) < chance) line(w, 0, w, h/2);
  if (random(100) < chance) line(0, h/2, 0, h);
  if (random(100) < chance) line(w, h/2, w, h);

  // diagonales
  if (random(100) < chance) line(0, 0, w/2, h/2);
  if (random(100) < chance) line(w/2, h/2, w, 0);
  if (random(100) < chance) line(0, h, w/2, h/2);
  if (random(100) < chance) line(w/2, h/2, w, h);
  pop();
}

void keyPressed() {
  newDraw = true;
}
