// Hatches
// topics: values, shaders, conditionals, loops, functions

void setup() {
  size(700, 700);
}

void draw() {
  background(255);
  smooth();

  drawValue(100, 250, 100, 100, 1);
  drawValue(200, 250, 100, 100, 2);
  drawValue(300, 250, 100, 100, 3);
  drawValue(400, 250, 100, 100, 4);
  drawValue(500, 250, 100, 100, 5);
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
