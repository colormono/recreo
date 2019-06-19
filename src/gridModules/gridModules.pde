Grid grid;

void setup() {
  size(600, 600);

  // create grid
  float[] margins = {50, 50, 50, 50};
  grid = new Grid(width, height, 21, 21, 10, 10, margins);
}

void draw() {
  background(255);
  noStroke();

  // draw grid
  grid.drawModules();
}

void mousePressed() {
  int moduleId = grid.getModuleIdByPosition(mouseX, mouseY);
  Module m = grid.getModuleById(moduleId);
  if (m != null) {
    println( moduleId, m );
    m.c = color(random(255), random(255), random(255));
  }
}
