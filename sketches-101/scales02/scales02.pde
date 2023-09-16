import processing.svg.*;

// Hatches
// topics: values, shaders, conditionals, loops, functions

void setup() {
  size(700, 700);

  noLoop();
}

void draw() {
  beginRecord(SVG, "render.svg");

  background(255);
  smooth();

  hatching(100, 100, 100, 100, 1);
  hatching(200, 100, 100, 100, 2);
  hatching(300, 100, 100, 100, 3);
  hatching(400, 100, 100, 100, 4);
  hatching(500, 100, 100, 100, 5);

  drawValue(100, 250, 100, 100, 1);
  drawValue(200, 250, 100, 100, 2);
  drawValue(300, 250, 100, 100, 3);
  drawValue(400, 250, 100, 100, 4);
  drawValue(500, 250, 100, 100, 5);

  stippling(100, 400, 100, 100, 1);
  stippling(200, 400, 100, 100, 2);
  stippling(300, 400, 100, 100, 3);
  stippling(400, 400, 100, 100, 4);
  stippling(500, 400, 100, 100, 5);

  endRecord();
}

void hatching(float x, float y, float w, float h, int shade) {
  int ll = 22; // line length
  int spaceY = 3;

  noFill();
  stroke(0);

  pushMatrix();
  translate(x, y);

  // bounds
  //rect(0, 0, w, h);

  if (shade == 1) {
    drawHatchingValue(w, h, 40, spaceY, ll);
  }
  if (shade == 2) {
    drawHatchingValue(w, h, 20, spaceY, ll);
  }
  if (shade == 3) {
    drawHatchingValue(w, h, 10, spaceY, ll);
  }
  if (shade == 4) {
    drawHatchingValue(w, h, 6, spaceY, ll);
  }
  if (shade == 5) {
    drawHatchingValue(w, h, 3, spaceY, ll);
  }

  popMatrix();
}

void drawHatchingValue(float w, float h, int spaceX, int spaceY, int lineLength) {
  int rows = floor(h / (lineLength + spaceY));
  println(rows);
  for (int col = 0; col < w; col += spaceX) {
    for (int row = 0; row < rows; row++) {
      line(col, (lineLength + spaceY)*row, col, (lineLength + spaceY)*row+lineLength);
    }
  }
}

void drawValue(float x, float y, float w, float h, int shade) {
  int spaceX = 10;
  int spaceY = 10;
  int innerSpace = 2;

  noFill();
  stroke(0);

  pushMatrix();
  translate(x, y);

  // all shades
  //rect(0, 0, w, h);

  if (shade >= 1) {
    // horizontal lines
    for (int row = 0; row < h; row += spaceY) {
      if (row < h-spaceY) {
        //line(0, row, w, row); // top
        //line(0, row+spaceY/2, w, row+spaceY/2); // center
        line(0, row+spaceY, w, row+spaceY); // bottom
      }

      if (shade >= 2) {
        // vertical lines
        for (int col = 0; col < w; col += spaceX) {
          line(col, 0, col, h); // left
          //line(col+spaceX/2, 0, col+spaceX/2, h); // center
          //line(col+spaceX, 0, col+spaceX, h); // right

          if (shade >= 3) {
            // lr diagonals
            line(col, row+spaceY, col+spaceX, row);

            if (shade >= 4) {
              // ub rl diagonals
              line(col, row, col+spaceX, row+spaceY);

              if (shade >= 5) {
                //rect(col, row, spaceX, spaceY); // bounds
                rect(col+innerSpace, row+innerSpace, spaceX-innerSpace*2, spaceY-innerSpace*2); // inside
              }
            }
          }
        }
      }
    }
  }

  popMatrix();
}

void stippling(float x, float y, float w, float h, int shade) {
  int amount = 10;

  noFill();
  stroke(0);

  pushMatrix();
  translate(x, y);

  // bounds
  //rect(0, 0, w, h);

  if (shade == 1) amount = 10;
  if (shade == 2) amount = 50;
  if (shade == 3) amount = 200;
  if (shade == 4) amount = 800;
  if (shade == 5) amount = 2000;

  for (int i = 0; i < amount; i++) {
    ellipse(random(w), random(h), 2, 2);
  }

  popMatrix();
}
