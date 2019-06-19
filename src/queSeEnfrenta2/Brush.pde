class Brush {
  float x; // x position
  float y; // y position
  float w; // width
  float h; // height
  int p; // pattern
  
  Brush(float _x, float _y, float _w, float _h, int _p){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
  }
  
  void draw(){
    switch(p){
     case 0:
       line(x, y, x+w, y+h);
       break;
     case 1:
       line(x+w, y, x, y+h);
       break;
    }       
  }  
}
