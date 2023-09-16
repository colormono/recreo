boolean animated = false;
boolean filled = false;
String filename;

void setup() {
  size(600, 800);
  pixelDensity(2);
}

void draw() {
  // composition
  // grilla con celdas superpuestas, 
  // dentro, figuras geométricas que rotan, 
  // relleno muare

  background(255);

  push();
  translate(120, height - 120);
  scale(1, -1);

  int rowsAmount = 4;
  int colsAmount = 9;

  int shapeWidth = 100;
  int shapeHeight = 100;
  int shapeMarginLeft = -53;
  int shapeMarginBottom = 77;

  // [row/col] module shape
  for (int row = 0; row < rowsAmount; row++) {
    for (int col = 0; col < colsAmount; col++) {

      int shapeX = col*shapeWidth + col*shapeMarginLeft;
      int shapeY = row*shapeHeight + row*shapeMarginBottom;

      push();

      float angle = 137.5; //360 / colsAmount
      float muare = (col - colsAmount/2) * 0.5;
      float shapeRotation = (angle * col * row) + muare;
      if (animated) shapeRotation += frameCount;

      //println("Shape", shapeX, shapeY, shapeWidth, shapeHeight, shapeRotation);

      translate(shapeX, shapeY);
      rotate(radians(shapeRotation));

      float value;
      if (row % 2 == 0) {
        value = map(col, 0, colsAmount-1, 30, 210);
      } else {
        value = map(col, 0, colsAmount-1, 210, 30);
      }


      drawColorShape(-shapeWidth/2, -shapeHeight/2, shapeWidth, shapeHeight, color(0, value));

      pop();
    }
  }

  filename = "Shape-r" + rowsAmount + "-c" + colsAmount + "-sw" +shapeWidth + "-sh" +shapeHeight + "-sml" + shapeMarginLeft + "-smb" + shapeMarginBottom;
  println(filename);
  // compoition ends

  pop();
}

void drawColorShape(float x, float y, float w, float h, color c) {
  int space = 3;     

  if (filled) {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  } else {
    stroke(c);
    noFill();
    for (int i=0; i <= h; i+= space) {
      line(x, y+i, x+w, y+i);
    }
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') animated = !animated;
  else if (key == 'f' || key == 'F') filled = !filled;
  else saveFrame(filename + "-" + random(1000) + ".png");
}
