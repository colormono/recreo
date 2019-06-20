import processing.svg.*;

String filename;
boolean saveSVG = false;

Grid grid;
float[] margins = {50, 50, 50, 50};
int cols = 9;
int rows = 9;
int gutter = 10;
boolean chaos = false;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);

  // create grid
  grid = new Grid(width, height, cols, rows, gutter, gutter, margins);
}

void draw() {
  background(#FFFFFF);

  if (saveSVG) beginRecord(SVG, filename + ".svg");
  noStroke();

  // draw grid
  grid.drawModules();

  // marcas de corte
  trimMarks();

  if (saveSVG) {
    endRecord();
    // Thumbnail
    saveFrame(filename + "-thumb.png");
    saveSVG = false;
  }
}

void mousePressed() {
  int moduleId = grid.getModuleIdByPosition(mouseX, mouseY);
  Module m = grid.getModuleById(moduleId);
  if (m != null) {
    println( moduleId, m.n );
    m.c = color(random(360), 100, 100);
  }
}

// interactions
void keyReleased() {
  filename = "prints/grid-" + timestamp();
  if (key == 'p' || key == 'P') saveSVG = true;
  if (key == 't' || key == 'T') chaos = !chaos;
  redraw();
}
