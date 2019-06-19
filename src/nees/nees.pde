/**
 * Que se enfrenta
 * forked from 10 Prints - diagonals in a grid
 *
 * Features:
 * - Multiple layer
 * - Basic pack of burshes
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

// Printing
ArrayList<Layer> layers;
String filename;
boolean saveSVG;
int actRandomSeed = 0;

// Composition
int margin = 30;
float cellSize = 20;
int padding = 4;
boolean newDraw = true;


void setup() {
  //println("size in mm should be " + toMM(151) +","+ toMM(242));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  //size(200, 320); // Figu
  size(595, 842); // A4
  // pixelDensity(2);

  // create an empty list to store the layers
  layers = new ArrayList<Layer>();
  layers.add(new Layer(1, rcol(), 0.7));
  println("Layers: " + layers.size());

  // create initial composition
  compose();
  smooth();
  noFill();
}

void draw() {
  if (newDraw) {
    // clean background
    background(255);

    // draw layers
    for (int l=0; l<layers.size(); l++) {
      // get current layer
      Layer layer = layers.get(l);

      // begin record layer
      if (saveSVG) beginRecord(SVG, filename + "-" + layer.index + ".svg");


      // draw composition
      stroke(layer.c);
      strokeWeight(layer.sw);

      for (int x=margin; x<width-margin*2; x+=cellSize+padding) {
        for (int y=margin; y<height-margin*3; y+=cellSize+padding) {

          // add error
          PVector error = new PVector(
            map(y, 0, height, 0, cellSize/2), 
            map(y, 0, height, 0, cellSize/2)
            );
          float r = map(y, 0, height, 0, cellSize*2);

          // draw a cross
          pushMatrix();
          translate(x+random(-error.x, error.x), y+random(-error.y, error.y));
          rotate(radians(random(-r, r)));
          rect(0, 0, cellSize, cellSize);
          popMatrix();
        }
      }
      newDraw = false;

      // end record layer
      if (saveSVG) endRecord();
    }
    if (saveSVG) saveSVG = false;
  }
}

void compose() {
  // set random seed
  randomSeed(actRandomSeed);
  newDraw = true;
  saveSVG = true;
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
}

void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

  if (key == 'c' || key == 'C') compose();
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
