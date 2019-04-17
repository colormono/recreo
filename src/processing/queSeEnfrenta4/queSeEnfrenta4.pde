/**
 * Que se enfrenta
 *
 * Figu: 534, 856
 * A4: 2100, 2970
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

ArrayList<String> placeholders;
PImage placeholder;
ArrayList<Layer> layers;
String filename;
boolean saveSVG = false;
boolean showPlaceholder = false;

int actRandomSeed = 0;
int tileCount = 80;

void setup() {
  // println("size in mm should be " + toMM(600) +","+ toMM(600));
  println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  //size(151, 242); // Figu
  size(595, 842); // A4
  //pixelDensity(2);

  // load placeholders
  placeholders = new ArrayList<String>();
  placeholders.add("piratebay.gif");
  placeholders.add("revolution.gif");
  placeholders.add("che.gif");
  placeholders.add("cuba.gif");
  placeholders.add("lkm.gif");

  // use placeholder
  placeholder = loadImage(placeholders.get(4));

  // create an empty list to store the layers
  layers = new ArrayList<Layer>();
  layers.add(new Layer(1, rcol(), toPX(0.7)));
  layers.add(new Layer(2, rcol(), toPX(3)));
  println("Layers: " + layers.size());

  // create initial composition
  compose();

  smooth();
  noFill();
}

void draw() {
  // clean background
  background(255);

  // draw placeholder
  if (!saveSVG && showPlaceholder) image(placeholder, 0, 0);

  // draw layers
  for (int l=0; l<layers.size(); l++) {
    // get current layer
    Layer layer = layers.get(l);

    if (saveSVG) beginRecord(SVG, filename + "-" + layer.index + ".svg");

    // draw composition
    stroke(layer.c);
    strokeWeight(layer.sw);
    strokeCap(SQUARE);

    for (int b=0; b<layer.composition.size(); b++) {
      // get and draw brush
      Brush brush = layer.composition.get(b);
      brush.draw();
    }

    if (saveSVG) {
      endRecord();
    }
  }

  if (saveSVG) {
    saveSVG = false;
  }
}

void compose() {
  // set random seed
  randomSeed(actRandomSeed);

  // set cell size
  float cellSize = width/tileCount;

  // create grid
  for (int y=0; y<height-cellSize; y+=cellSize) {
    for (int x=0; x<width-cellSize; x+=cellSize) {

      // process image
      int px = int(map(x, 0, width, 0, placeholder.width));
      int py = int(map(y, 0, height, 0, placeholder.height));
      float pixelBright = brightness(placeholder.get(px, py));
      int p = pixelBright > 145 ? 1 : 0;

      // create brush
      Brush brush = new Brush(x, y, cellSize, cellSize, p);

      // select layer
      int l = pixelBright > 145 ? 1 : 0;;

      // push brush into layer composition
      layers.get(l).composition.add(brush);
    }
  }
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
}

void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

  if (key == 'c' || key == 'C') {
    compose();
  }

  if (key == 'h' || key == 'H') {
    showPlaceholder = !showPlaceholder;
  }

  if (key == 's' || key == 'S') {
    saveFrame(filename + ".png");
  }

  if (key == 'p' || key == 'P') {
    saveFrame(filename + ".png");
    saveSVG = true;
  }
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
