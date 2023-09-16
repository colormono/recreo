boolean animated = false;
boolean filled = false;
String filename;

void setup() {
  size(700, 800);
}

void draw() {
  background(255);
  push();
  translate(100, 150);

  // composition
  // grilla con celdas superpuestas, 
  // dentro, figuras geométricas que rotan, 
  // relleno muare
  int rowsAmount = 4;
  int colsAmount = 9;

  int shapeWidth = 100;
  int shapeHeight = 100;
  int shapeMarginLeft = -54;
  int shapeMarginBottom = 50;

  // [row/col] module shape
  for (int row = 0; row < rowsAmount; row++) {
    for (int col = 0; col < colsAmount; col++) {

      int shapeX = col*shapeWidth + col*shapeMarginLeft;
      int shapeY = row*shapeHeight + row*shapeMarginBottom;

      push();

      float shapeRotation = (180 / colsAmount) * (col * row);
      if (animated) shapeRotation += frameCount;

      //println("Shape", shapeX, shapeY, shapeWidth, shapeHeight, shapeRotation);

      translate(shapeX, shapeY);
      rotate(radians(shapeRotation));

      drawColorShape(-shapeWidth/2, -shapeHeight/2, shapeWidth, shapeHeight, color(0, 255/colsAmount*col));

      pop();
    }
  }

  filename = "Shape-r" + rowsAmount + "-c" + colsAmount + "-sw" +shapeWidth + "-sh" +shapeHeight + "-sml" + shapeMarginLeft + "-smb" + shapeMarginBottom;
  println(filename);
  // compoition ends

  pop();
}

void drawColorShape(float x, float y, float w, float h, color c) {
  if (filled) {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  } else {
    stroke(c);
    noFill();
    int space = 2;
    for (int i=0; i <= w; i+= space) {
      line(x*i, y, x+w*i, y+h);
    }
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') animated = !animated;
  else if (key == 'f' || key == 'F') filled = !filled;
  else saveFrame(filename + ".png");
}
