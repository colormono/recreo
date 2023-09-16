//https://www.tamanosdepapel.com/a-tamanos-en-pixeles.htm

import processing.svg.*;

boolean record;

void setup() {
  size(595, 842); // A4 72 PPI/DPI
}

void draw() {
  if (record) {
    beginRaw(SVG, "output.svg");
  }

  // Do all your drawing here
  float r = width*0.66;
  ellipse(width*0.5, height*0.33, r, r);

  if (record) {
    endRaw();
    record = false;
  }
}

// Hit 'r' to record a single frame
void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}
