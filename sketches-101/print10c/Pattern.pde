class Pattern {
  int lines;

  Pattern(int _lines) {
    lines = _lines;
  }

  void draw(int x, int y, int cellSize, boolean mirrored) {
    int counter = 0;
    for (int i = 0; i < cellSize; i += spaceBtw) {
      stroke(colors[ counter % colors.length ]);
      line(x+i, y, x+cellSize, y+cellSize-i);
      counter++;
    }

    counter = lines;
    for (int i = 0; i < cellSize; i += spaceBtw) {
      stroke(colors[ counter % colors.length ]);
      if( i != 0) line(x, y+i, x+cellSize-i, y+cellSize);
      counter--;
    }
  }
}
