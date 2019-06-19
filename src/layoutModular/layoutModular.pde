// Layout modular
import processing.svg.*;

float[] margins = {0, 0, 0, 0};
int gutterCols = 0;
int gutterRows = 0;
int cols = 9;
int rows = 9;

void setup() {
  size(548, 768);
  noLoop();
}

void draw() {
  background(255);
  
  beginRecord(SVG, "layoutModular"+cols+"x"+rows+".svg");
  noFill();

  // margins
  line(0, margins[0], width, margins[0]);
  line(width-margins[1], 0, width-margins[1], height);
  line(0, height-margins[2], width, height-margins[2]);
  line(margins[3], 0, margins[3], height);

  // modules
  float moduleWidth = (width-margins[1]-margins[3]-(gutterCols*(cols-1)))/cols;
  float moduleHeight = (height-margins[0]-margins[2]-(gutterRows*(rows-1)))/rows;
  println("Module size", moduleWidth, moduleHeight);

  // translate inside
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

  endRecord();
}
