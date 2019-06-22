/**
 * patterns in a grid
 * - Multiple layer support
 *
 * MOUSE
 * left click          : new random layout
 * 
 * KEYS
 * c                   : compose
 * s                   : save png
 * p                   : print svgs
 * t                   : toggle order/chaos
 */
// TO DO:
// - Order patterns by value (lighter to darker)

import processing.svg.*;  
boolean saveSVG = false;  // handle SVG saving
String filename;          // handle filename
ArrayList<Layer> layers;  // store layers

// Setup grid system
Grid grid;
float[] margins = {50, 50, 50, 50};
int cols = 18;
int rows = 18;
int gutter = 0;

// Setup randomness
int seed = 1;
boolean chaos = false;


void setup() {
  println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  size(595, 842);
  smooth();
  noFill();

  // create layers
  layers = new ArrayList<Layer>();
  layers.add(new Layer(1, #000000, toPX(2)));
  layers.add(new Layer(2, #FF0000, toPX(5)));
  layers.add(new Layer(3, #0000FF, toPX(5)));
  println("Layers: " + layers.size());

  // create grid
  grid = new Grid(width, height, cols, rows, gutter, gutter, margins);

  // start
  compose();
}

void draw() {
  // clean background
  background(255);

  // for each layers
  for (int l=0; l<layers.size(); l++) {
    // get current layer
    Layer layer = layers.get(l);
    if (saveSVG) beginRecord(SVG, filename + "-" + layer.index + ".svg");

    // setup layer
    stroke(layer.c);
    strokeWeight(layer.sw);
    strokeCap(SQUARE);

    // draw layer composition
    for (int b=0; b<layer.composition.size(); b++) {
      Brush brush = layer.composition.get(b);
      brush.draw();
    }

    // draw helpers
    // grid.drawMargins();
    // grid.drawModules();
    trimMarks();

    if (saveSVG) endRecord();
  }

  if (saveSVG) {
    saveFrame(filename + ".png");
    saveSVG = false;
  }
}

// Composition rules
void compose() {
  // first, clean layers (descending order)
  for (int l=0; l<layers.size(); l++) {
    Layer layer = layers.get(l);
    layer.clean();
  }

  // set random seed
  randomSeed(seed);

  // create grid
  for (int y=0; y<rows; y++) {        
    for (int x=0; x<cols; x++) {
      // create module
      float mx = grid.getModuleX(x);
      float my = grid.getModuleY(y);

      // logic to pick brush for each module
      //int px = int(map(x, 0, width, 0, placeholder.width));
      //int py = int(map(y, 0, height, 0, placeholder.height));
      //float pixelBright = brightness(placeholder.get(px, py));
      int p = 0;
      if (chaos) {
        // random
        p = floor(random(6));
      } else {
        // math
        // p = floor(dist(x, y, width/2, height/2) % layers.size());
        p = floor(sqrt(x+y) % 6);
        //p = floor(aureo(x+y, true) % layers.size());
      }

      // create brush
      Brush brush = new Brush(mx, my, grid.moduleWidth, grid.moduleHeight, p);

      // push brush into selected layer
      int l = floor(random(3));
      layers.get(l).composition.add(brush);
    }
  }
}

// interactions
void mousePressed() {
  // seach in each layer
  for (int l=0; l<layers.size(); l++) {
    Layer layer = layers.get(l);
    // for a brush by position and grab the id
    int _id = layer.getBrushIdByPosition(mouseX, mouseY);
    Brush b = layer.getBrushById(_id);
    if (b != null) b.nextPattern();
  }
}

void keyReleased() {
  seed = (int) random(100000);
  filename = "prints/" + timestamp() + "-" + seed;
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  if (key == 'p' || key == 'P') saveSVG = true;
  if (key == 'c' || key == 'C') compose();
  if (key == 't' || key == 'T') {
    chaos = !chaos;
    compose();
  };
}
