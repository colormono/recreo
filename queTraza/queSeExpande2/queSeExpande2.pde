/**
 * Que se expande
 *
 * MOUSE
 * left click          : new random layout
 * 
 * KEYS
 * h                   : show/hide placeholder
 * c                   : compose
 * s                   : save png
 * p                   : save pdf
 */
import processing.svg.*;
import java.util.Calendar;

// Base
String filename;
boolean saveSVG;
int actRandomSeed = 0;

// Customize
int layers = 1;

void setup() {
  // println("size in mm should be " + toMM(151) +","+ toMM(242));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  // size(200, 320); // Figu
  size(595, 842); // A4
  pixelDensity(2);

  // create initial composition
  smooth();
  noFill();
}

void draw() {
  // clean background
  background(255);

  // draw layers
  for (int l=0; l<layers; l++) {
    // begin record layer
    if (saveSVG) beginRecord(SVG, filename + "-" + l + ".svg");

    // draw composition
    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    strokeWeight(0.7);
    if (l == 0) {
      float radius = 0;
      float angle = 0;
      float x = 0, y = 0;
      float lastX = -999;
      float lastY = -999;

      while (x <= width/2) {
        float r = 3;
        float rad = radians(angle);
        x = radius * cos(rad) + random(-r, r);
        y = radius * sin(rad) + random(-r, r);
        if (lastX > -999) line(x, y, lastX, lastY);

        radius += 0.1;
        angle += 3;
        lastX = x;
        lastY = y;
      }
    }
    popMatrix();

    // end record layer
    if (saveSVG) endRecord();
  }
  if (saveSVG) saveSVG = false;
}


void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

  //if (key == 'c' || key == 'C') compose();
  //if (key == 'h' || key == 'H') showPlaceholder = !showPlaceholder;
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  if (key == 'p' || key == 'P') {
    saveFrame(filename + ".png");
    saveSVG = true;
  }

  // if (keyCode == DOWN) tileCountY = max(tileCountY-1, 1);
  // if (keyCode == UP) tileCountY += 1;
  // if (keyCode == LEFT) tileCountX = max(tileCountX-1, 1);
  // if (keyCode == RIGHT) tileCountX += 1;
}

// unit conversion
int toMM(int px) {
  return int(px*35.277/100);
}

float toPX(float mm) {
  return mm/3.527783333;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

// color
int colors[] = {#F46324, #0111A3, #FFD65E, #00C191, #8BD7D2, #538BFC, #F2E1E1, #C96FDB, #964CAA, #EDAC34, #FF66A5};
int rcol() {
  int col = colors[int(random(colors.length))];
  //int col2 = colors[int(random(colors.length))];
  //col = lerpColor(col, col2, random(0.04));
  return col;
}
