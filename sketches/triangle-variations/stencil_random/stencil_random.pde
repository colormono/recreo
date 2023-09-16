// single unit with random behavior
int w = 20;
int h = 17;
int[][] lines = {
  {0, 0, w*2, 0},
  {0, 0, w, h*2},
  {w, h*2, w*2, 0},
  {w*2, 0, w*3, h*2},
  {w*3, h*2, w, h*2},
  {w, h*2, 0, h*4},
  {0, h*4, w*2, h*4},
  {w*2, h*4, w, h*2},
  {w*2, h*4, w*3, h*2},
  {w*3, h*2, w*4, h*4},
  {w*4, h*4, w*2, h*4}
};
boolean next = true;

void setup() {
  size(100, 88);
  pixelDensity(displayDensity(2));
  smooth();
}

void draw() {
  if (next) {
    background(0);
    pushMatrix();
    translate(10, 10);

    for (int i = 0; i < lines.length; i++) {
      if ( random(100) > 50 ) {
        stroke(255);
      } else {
        stroke(80);
      }
      line(lines[i][0], lines[i][1], lines[i][2], lines[i][3]);
    }

    popMatrix();
  }
  next = false;
}

void mousePressed() {
  next = true;
}
