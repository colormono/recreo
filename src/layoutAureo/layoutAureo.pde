// calcular numero aureo
// a = (a+b)/a*b

void setup() {
  size(562, 794);
  noLoop();
}

void draw() {
  background(255);
  int w = 50;
  line(0, 10, aureo(w, true), 10);
  line(0, 15, w, 15);
  line(0, 20, aureo(w, false), 20);
}

float aureo(float side, boolean next) {
  float ratio = ((1+sqrt(5))/2);
  if (!next) return side * 1/ratio;
  return side * ratio;
}
