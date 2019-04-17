import java.util.Calendar;
import processing.svg.*;

PImage placeholder;
PGraphics pg;
boolean saveIMG = false;

int layers = 1;
PShape[] result = new PShape[1];
Pattern[] grid = {};

float cellSize = 40;
String filename;

void setup() {
  //size(2560, 1440);
  //size(1190, 1684);
  size(595, 842);
  placeholder = loadImage("01.jpg");

  createImage();
  noLoop();
}

void createImage() {
  // limpiar grilla
  grid = new Pattern[0];

  // pintar
  // para cada celda de la grilla
  for (int y=0; y<=height; y+=cellSize) {
    for (int x=0; x<=width; x+=cellSize) {
      // generar un pattern
      int layer = floor(random(layers));
      Pattern p = new Pattern(pg, layer, x, y, cellSize);
      // insertarlo en la grilla
      grid = (Pattern[]) append(grid, p);
    }
  }
  drawComposition();
}

void drawComposition() {

  pg = createGraphics(width, height, SVG, filename+"-"+l+".svg");
  pg.beginDraw();
  pg.shapeMode(CENTER);
  //pg.background(255);

  // para cada celda
  for (int i=0; i<grid.length; i++) {
    pg.stroke(0);
    pg.strokeWeight(1);
    if (l == grid[i].layer) {
      grid[i].drawPattern(grid[i].layer + 1);
    }
  }
  pg.dispose();
  pg.endDraw();

  // imprimir resultado
  result[l] = loadShape("print-layer-"+l+".svg");
  shapeMode(CORNER);
  shape(result[l], 0, 0);
  saveFrame(filename+"-"+l+".png");
}
}

void mousePressed() {
  createImage();
}

void draw() {
  // clean background
  background(255);

  // draw placeholder
  image(placeholder, 0, 0);

  // save composition
  // para cada layer 
  for (int l=0; l<layers; l++) {

    if (saveIMG) {
      // set filename
      filename = "print-"+timestamp();
      beginRecord(SVG, filename+".svg");
    }

    // draw composition
    drawComposition();

    if (saveIMG) {
      endRecord();
      saveIMG = false;
    }
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') saveIMG = true;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
