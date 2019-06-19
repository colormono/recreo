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
import processing.svg.*;
ArrayList<Layer> layers;
String filename;
boolean saveSVG = false;
int seed = 0;


int tileCount = 20;
boolean chaos = false;


void setup() {
  // println("size in mm should be " + toMM(600) +","+ toMM(600));
  println("size in px should be " + toPX(2100) +", "+ toPX(2970));
  //size(151, 242); // Figu
  size(595, 842); // A4

  // create an empty list to store the layers
  layers = new ArrayList<Layer>();
  layers.add(new Layer(1, #000000, toPX(2)));
  layers.add(new Layer(2, #FF0000, toPX(5)));
  layers.add(new Layer(3, #0000FF, toPX(5)));
  println("Layers: " + layers.size());

  // create initial composition
  compose();

  smooth();
  noFill();
}

void draw() {
  // clean background
  background(255);

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
      //pushMatrix();
      //translate(width/2, height/2);
      //rotate(radians(map(dist(brush.x, brush.y, width/2, height/2), 0, height/2, 0, 360)));
      brush.draw();
      //popMatrix();
    }

    // marcas de corte
    trimMarks();

    if (saveSVG) {
      endRecord();
    }
  }

  if (saveSVG) {
    saveSVG = false;
  }
}

// Composition rules
void compose() {
  // clean layers (descending order)
  for (int l=0; l<layers.size(); l++) {
    Layer layer = layers.get(l);
    for (int b=layer.composition.size()-1; b>=0; b--) {
      layer.composition.remove(b);
    }
  }

  // set random seed
  randomSeed(seed);

  // set cell size
  float cellSize = width/tileCount;

  // create grid
  for (int y=0; y<height-cellSize; y+=cellSize) {
    for (int x=0; x<width-cellSize; x+=cellSize) {

      // random pick
      // select layer
      //int px = int(map(x, 0, width, 0, placeholder.width));
      //int py = int(map(y, 0, height, 0, placeholder.height));
      //float pixelBright = brightness(placeholder.get(px, py));

      int p = 0;
      if (chaos) {
        // random
        p = floor(random(200) % layers.size());
      } else {
        // math
        // p = floor(dist(x, y, width/2, height/2) % layers.size());
        // p = floor(sqrt(x+y) % layers.size());
        // p = floor(aureo(x+y, true) % layers.size());
        p = floor(aureo(dist(x, y, width/2, height/2), true) % layers.size());
      }

      // create brush
      Brush brush = new Brush(x, y, cellSize, cellSize, p);

      // push brush into layer composition
      layers.get(p).composition.add(brush);
    }
  }
}

// interactions
void keyReleased() {
  seed = (int) random(100000);
  filename = "prints/" + timestamp() + "-" + seed;
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  if (key == 'p' || key == 'P') {
    saveFrame(filename + ".png");
    saveSVG = true;
  }

  if (key == 'c' || key == 'C') compose();
  if (key == 't' || key == 'T') {
    chaos = !chaos;
    compose();
  };
}
