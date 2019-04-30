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
}
