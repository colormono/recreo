// Use multiples of 4
import processing.svg.*;

int cellSize = 80;
int spaceBtw = 8;
color[] colors = { #00CCFF, #DD00CC, #000000, #CCCCCC };

Pattern p;
boolean render = true;

void setup() {
  size(400, 600);

  p = new Pattern(cellSize/spaceBtw);
}

void draw() {
  if (render) {
    background(255);
    beginRecord(SVG, "render.svg");

    for (int x = 0; x < width; x += cellSize) {
      for (int y = 0; y < height; y += cellSize) {
        if (random(100) < 50) {
          p.draw(x, y, cellSize, false);
        } else {
          pushMatrix();
          translate(x+cellSize, y);
          scale(-1, 1);
          p.draw(0, 0, cellSize, false);
          popMatrix();
        }
      }
    }

    endRecord();
    render = false;
  }
}

// Generate new artwork

void mousePressed() {
  render = true;
}
