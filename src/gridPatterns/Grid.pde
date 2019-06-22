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
  float[] margins = new float[4];
  float moduleWidth, moduleHeight;

  Grid(float _w, float _h, int _cols, int _rows, int _gutterCols, int _gutterRows, float[] _margins) {
    w = _w;
    h = _h;
    cols = _cols;
    rows = _rows;
    gutterCols = _gutterCols;
    gutterRows = _gutterRows;
    margins = _margins;
    moduleWidth = (w-margins[1]-margins[3]-(gutterCols*(cols-1)))/cols;
    moduleHeight = (h-margins[0]-margins[2]-(gutterRows*(rows-1)))/rows;
    println("Base module size", moduleWidth, moduleHeight);
  }

  float getModuleX(int x) {
    return (x > 0) ? x*grid.moduleWidth+grid.gutterCols*x+grid.margins[3] : x*grid.moduleWidth+grid.margins[3];
  }

  float getModuleY(int y) {
    return (y > 0) ? y*grid.moduleHeight+grid.gutterRows*y+grid.margins[0] : y*grid.moduleHeight+grid.margins[0];
  }

  void drawMargins() {
    line(0, margins[0], w, margins[0]);
    line(w-margins[1], 0, w-margins[1], h);
    line(0, h-margins[2], w, h-margins[2]);
    line(margins[3], 0, margins[3], h);
  }

  void drawModules() {
    stroke(0);
    strokeWeight(1);
    for (int y=0; y<rows; y++) {        
      for (int x=0; x<cols; x++) {
        float moduleX = (x > 0) ? x*moduleWidth+gutterCols*x+margins[3] : x*moduleWidth+margins[3];
        float moduleY = (y > 0) ? y*moduleHeight+gutterRows*y+margins[0] : y*moduleHeight+margins[0];
        rect(moduleX, moduleY, moduleWidth, moduleHeight);
      }
    }
    noStroke();
  }
}
