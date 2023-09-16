int cellSize = 40;
boolean render = true;

Pattern p;

void setup() {
  size(400, 400);

  p = new Pattern();
}

void draw() {
  if (render) {
    background(255);

    for (int x = 0; x < width; x += cellSize) {
      for (int y = 0; y < height; y += cellSize) {
        p.draw(x, y, cellSize);
      }
    }

    render = false;
  }
}

void mousePressed() {
  render = true;
}
