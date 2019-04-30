/**
 * Que se expande
 * forked from Phyllotaxy
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

// Layers
ArrayList<Layer> layers;
String filename;
boolean saveSVG;

// Image processing
ArrayList<String> placeholders;
PImage placeholder;

// Customize
boolean showPlaceholder = false;
int actRandomSeed = 0;
int dots = 2600;
float dotScale = 0.1;
float dotSizeMin = 1;
float dotSizeMax = 5;

void setup() {
  //println("size in mm should be " + toMM(151) +","+ toMM(242));
  // println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  //size(200, 320); // Figu
  size(595, 842); // A4
  // pixelDensity(2);

  // load placeholders
  placeholders = new ArrayList<String>();
  placeholders.add("twain.jpg");
  placeholders.add("flower.jpg");
  placeholders.add("mountain.jpg");

  // use placeholder
  placeholder = loadImage(placeholders.get(0));

  // create an empty list to store the layers
  layers = new ArrayList<Layer>();
  layers.add(new Layer(1, #FFFFFF, 0.7));
  println("Layers: " + layers.size());

  // create initial composition
  compose();
  smooth();
  noFill();
  imageMode(CENTER);
}

void draw() {
  // clean background
  background(0);

  // draw placeholder
  if (!saveSVG && showPlaceholder) image(placeholder, width/2, height/2, width, height);

  // draw layers
  for (int l=0; l<layers.size(); l++) {
    // get current layer
    Layer layer = layers.get(l);

    // begin record layer
    if (saveSVG) beginRecord(SVG, filename + "-" + layer.index + ".svg");

    // draw composition
    stroke(layer.c);
    strokeWeight(layer.sw);
    fill(255);
    noStroke();

    for (int b=0; b<layer.composition.size(); b++) {
      // get and draw brush
      Brush brush = layer.composition.get(b);
      brush.draw(layer.sw);
    }

    // end record layer
    if (saveSVG) endRecord();
  }
  if (saveSVG) saveSVG = false;
}

void compose() {
  // set random seed
  randomSeed(actRandomSeed);

  // create grid
  PVector origin = new PVector(width/2, height/2);

  for (int i=10; i<dots; i++) {
    float _x = i*sin(i);
    float _y = i*cos(i);

    // New point
    float x = _x * dotScale + origin.x;
    float y = _y * dotScale + origin.y;

    // process image
    // use bright to change ellipse radius
    int px = int(map(x, 0, width, 0, placeholder.width));
    int py = int(map(y, 0, height, 0, placeholder.height));
    float pixelBright = brightness(placeholder.get(px, py));
    float size = map(pixelBright, 0, 255, dotSizeMin, dotSizeMax);
    // float size = 1+i/25;

    // pick a brush
    Brush brush = new Brush(0, x, y, size, size);

    // select layer
    int l = 0;

    // push brush into layer composition
    layers.get(l).composition.add(brush);
  }
}

void keyReleased() {
  filename = "prints/" + timestamp() + "-" + actRandomSeed;

  if (key == 'c' || key == 'C') compose();
  if (key == 'h' || key == 'H') showPlaceholder = !showPlaceholder;
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
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
