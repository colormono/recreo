// Layout modular
import processing.svg.*;
Grid grid;

void setup() {
  size(562, 794);

  // instantiate grid
  float[] margins = {30, 70, 50, 50};
  grid = new Grid(width, height, 6, 5, 20, 20, margins);

  noLoop();
}

void draw() {
  background(255);
  beginRecord(SVG, "layoutModular"+grid.cols+"x"+grid.rows+".svg");
  grid.drawMargins();
  grid.drawModules();
  endRecord();
}
