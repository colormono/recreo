class Pattern {
  int spaceBtw = 4;

  void Pattern() {
  }

  void draw(int x, int y, int cellSize) {
    if (random(100) < 50) {
      for (int i = 1; i < cellSize; i += spaceBtw) {
        line(x, y, x+cellSize, y+cellSize);
        line(x+i, y, x+cellSize, y+cellSize);
      }
    } else {
      line(x+cellSize, y, x, y+cellSize);
    }
  }

  void trama() {
  }
}
