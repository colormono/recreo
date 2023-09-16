class Pattern {
  int spaceBtw = 8;

  void Pattern() {
  }

  void draw(int x, int y, int cellSize) {
    for (int i = 0; i < cellSize; i += spaceBtw) {
      line(x+i, y, x+cellSize, y+cellSize-i);
      if (i != 0) line(x, y+i, x+cellSize-i, y+cellSize);
    }
  }
}
