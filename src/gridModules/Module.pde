class Module {
  float x, y, w, h;
  float centerX, centerY;
  color c;

  Module(float moduleX, float moduleY, float moduleWidth, float moduleHeight) {
    x = moduleX;
    y = moduleY;
    w = moduleWidth;
    h = moduleHeight;
    centerX = x+w/2;
    centerY = y+h/2;
    c = 0;
  }

  void draw() {
    float d = dist(centerX, centerY, width/2, height/2);
    float r = map(d, 0, width/2, 0, w); 
    fill(c);
    //rect(x, y, w, h);
    ellipse(centerX, centerY, r, r);
  }
}
