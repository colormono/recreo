class Layer {
  int index; // Id
  color c; // Color
  float sw; // Stroke weight
  ArrayList<Brush> composition; // list of elements

  Layer(int _index, color _c, float _sw) {
    index = _index;
    c = _c;
    sw = _sw;

    // Create an empty ArrayList to store the composition
    composition = new ArrayList<Brush>();
  }

  int getBrushIdByPosition(int x, int y) {
    for (int m=0; m<composition.size(); m++) {
      Brush _m = composition.get(m);
      if (x >= _m.x && x<= _m.x+_m.w && y >= _m.y && y<= _m.y+_m.h) {
        return m;
      }
    }
    return -1;
  }

  Brush getBrushById(int id) {
    if (id >=0 && id < composition.size()) {
      return composition.get(id);
    }
    return null;
  }

  void clean() {
    for (int b=composition.size()-1; b>=0; b--) {
      composition.remove(b);
    }
  }
}
