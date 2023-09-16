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
  ArrayList<Module> modules;

  Grid(float _w, float _h, int _cols, int _rows, int _gutterCols, int _gutterRows, float[] _margins) {
    w = _w;
    h = _h;
    cols = _cols;
    rows = _rows;
    gutterCols = _gutterCols;
    gutterRows = _gutterRows;
    margins = _margins;

    // create modules
    int id = 0;
    float moduleWidth = (w-margins[1]-margins[3]-(gutterCols*(cols-1)))/cols;
    float moduleHeight = (h-margins[0]-margins[2]-(gutterRows*(rows-1)))/rows;
    println("Module size", moduleWidth, moduleHeight);
    modules = new ArrayList<Module>();
    for (int y=0; y<rows; y++) {        
      for (int x=0; x<cols; x++) {
        float moduleX = (x > 0) ? x*moduleWidth+gutterCols*x+margins[3] : x*moduleWidth+margins[3];
        float moduleY = (y > 0) ? y*moduleHeight+gutterRows*y+margins[0] : y*moduleHeight+margins[0];
        modules.add(new Module(id, moduleX, moduleY, moduleWidth, moduleHeight));
        id++;
      }
    }
  }

  int getModuleIdByPosition(int x, int y) {
    for (int m=0; m<modules.size(); m++) {
      Module _m = modules.get(m);
      if (x >= _m.x && x<= _m.x+_m.w && y >= _m.y && y<= _m.y+_m.h) {
        return m;
      }
    }
    return -1;
  }

  Module getModuleById(int id) {
    if (id >=0 && id < modules.size()) {
      return modules.get(id);
    }
    return null;
  }

  void drawMargins() {
    line(0, margins[0], w, margins[0]);
    line(w-margins[1], 0, w-margins[1], h);
    line(0, h-margins[2], w, h-margins[2]);
    line(margins[3], 0, margins[3], h);
  }

  void drawModules() {
    for (int m=0; m<modules.size(); m++) {
      Module _m = modules.get(m);
      _m.draw();
    }
  }
}
