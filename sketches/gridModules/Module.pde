class Module {
  int id;
  float x, y, w, h;
  float centerX, centerY;
  int row, col, n;
  color c;

  Module(int _id, float _x, float _y, float _w, float _h) {
    id = _id;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    centerX = x+w/2;
    centerY = y+h/2;
    row = floor(id/cols);
    col = id % cols;
    n = col - row;
    c = color(map(n, -cols+1, cols-1, 0, 360), 100, 100);
  }

  void draw() {
    //float d = dist(centerX, centerY, width/2, height/2);
    float d = dist(centerX, centerY, width/2, height/2);
    // d = map(d, -width/2, width/2, -90, 90);
    // float r = map(d, 0, width/2, 0, w*.77); 
    // fill(200, 0, 0, 100);
    // rect(x, y, w, h);

    push();
    translate(centerX, centerY);
    rotate(radians(d+mouseX));
    fill(c, 50);
    // rect(-w/2, -h/2, w, h);
    rectMode(CENTER);
    rect(0, 0, w, h/2);

    fill(c);
    //ellipse(0, 0, w/4, w/4);
    pop();
  }
}
