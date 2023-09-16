/**
 Based on Organic
 https://www.openprocessing.org/sketch/534454
 */
import processing.svg.*;  

Iris[] newIris = new Iris[1000];

// noise factors
float noiseScale = 500, noiseStrength = 50;

// noise display factors
float overlayAlpha = 0, irisAlpha = 255, strokeWidth = .3;

// main circle parameters
float radius = 100;
float rTemp = radius;

// animation related variables
float limit = 100, timer = 0;

// colors
color bckg = #000000, c1 = #ffffff;


// Export
boolean saveSVG = false;      // handle SVG saving
String filename;              // handle filename
int seed = 16091983;

void setup() {
  size(758, 1072);
  smooth();
  background(bckg);

  for (int i = 0; i < newIris.length; i++) {
    newIris[i] = new Iris();
  }
}

void draw() {
  // background related
  fill(bckg, overlayAlpha);
  rect(-5, -5, width+10, height+10);
  background(bckg);

  // Start plotter drawing
  if (saveSVG) beginRecord(SVG, filename + ".svg");

  if ( (timer = (timer + .5)) > limit - 20) {
    // this is for that quick fade at the end of a cycle
    fill(bckg, overlayAlpha + 40);
    rect(-5, -5, width+10, height+10);
  }

  // Animate Iris
  for (int i = 0; i < newIris.length; i++) newIris[i].drawIris(c1);

  // reset parameters every time 'limit' is hit
  if ( (timer = (timer + .5) % limit) == 0 ) {
    for (int i = 0; i < newIris.length; i++) {
      newIris[i].reDrawIt();
    }
  }

  // Stop plotter drawing
  if (saveSVG) {
    endRecord();
    saveFrame(filename + ".png");
    saveSVG = false;
  }

  // guardar todas las posiciones en cada frame
  // dibujar todo en el mismo cuadro
  // resetear cuando termina
}


void keyReleased() {
  seed = (int) random(100000);
  filename = "prints/" + timestamp() + "-" + seed;
  randomSeed(seed);

  // save just an image
  if (key == 's' || key == 'S') saveFrame(filename + ".png");

  // save print files
  else if (key == 'p' || key == 'P') saveSVG = true;

  // compose
  else println("noise is gold");
}
