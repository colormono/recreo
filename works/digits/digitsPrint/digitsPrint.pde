import processing.svg.*;
boolean saveSVG = false;  // handle SVG saving
String filename;          // handle filename

boolean newDraw = true;

int mt = 40;
int mr = 4;
int mb = 4;
int ml = 35;

int w = 8;
int h = 16;

void setup() {
  size(309, 500);
  //  println("size in px should be " + toPX(2000) +", "+ toPX(2900));
  //  size(595, 842);
}

void draw() {
  if (newDraw) {
    if (saveSVG) beginRecord(SVG, filename + ".svg");

    background(#001DCE);
    stroke(255);
    strokeWeight(1);

    int rows = 20;
    int cols = 20;
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

    if (saveSVG) {
      endRecord();

      saveFrame(filename + ".png");
      saveSVG = false;
    }
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
  filename = "prints/" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  else if (key == 'p' || key == 'P') saveSVG = true;
}
