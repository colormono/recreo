class Pattern {
  int x, y;
  boolean flip;

  Pattern(int _x, int _y, boolean _flip) {
    x = _x;
    y = _y;
    flip = _flip;
  }

  void display(int layer) {
    stroke(colors[layer]);

    //if (flip) {
    pushMatrix();
    translate(x, y);
    for (int i = 0; i < cellSize; i += spaceBtw) {
      line(i, 0, cellSize, cellSize-i);
      if ( i != 0) line(0, i, cellSize-i, cellSize);
    }
    popMatrix();
    //} else {
    //  pushMatrix();
    //  translate(x+cellSize, y);
    //  scale(-1, 1);
    //  p.draw(0, 0, cellSize, false);
    //  popMatrix();
    //}
  }
}
