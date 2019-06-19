// Grid
/* Example:

// create grid
float[] margins = {30, 70, 50, 50};
grid = new Grid(width, height, 6, 5, 20, 20, margins);

// draw grid
grid.drawMargins();
grid.drawModules();

*/
class Grid {
  float w, h;
  int cols, rows;
  int gutterCols, gutterRows;
  float moduleWidth, moduleHeight;
  float[] margins = new float[4];

  Grid(float _w, float _h, int _cols, int _rows, int _gutterCols, int _gutterRows, float[] _margins) {
    w = _w;
    h = _h;
    cols = _cols;
    rows = _rows;
    gutterCols = _gutterCols;
    gutterRows = _gutterRows;
    margins = _margins;

    // module
    moduleWidth = (w-margins[1]-margins[3]-(gutterCols*(cols-1)))/cols;
    moduleHeight = (h-margins[0]-margins[2]-(gutterRows*(rows-1)))/rows;
    println("Module size", moduleWidth, moduleHeight);
  }

  void drawMargins() {
    line(0, margins[0], w, margins[0]);
    line(w-margins[1], 0, w-margins[1], h);
    line(0, h-margins[2], w, h-margins[2]);
    line(margins[3], 0, margins[3], h);
  }

  void drawModules() {
    pushMatrix();
    translate(margins[3], margins[0]);
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        float moduleX = (x > 0) ? x*moduleWidth+gutterCols*x : x*moduleWidth;
        float moduleY = (y > 0) ? y*moduleHeight+gutterRows*y : y*moduleHeight;
        rect(moduleX, moduleY, moduleWidth, moduleHeight);
      }
    }
    popMatrix();
  }
}
