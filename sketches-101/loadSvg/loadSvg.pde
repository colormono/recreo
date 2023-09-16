/*
  Equivalent A4 paper dimensions in pixels at 300 DPI and 72 DPI respectively are: 
  2480 pixels x 3508 pixels (print resolution) 
  595 pixels x 842 pixels (screen resolution)
*/
import processing.svg.*;
PGraphics pg;
PShape result;
PShape pattern;

void setup() {
  size(595, 842);

  // cargar pattern
  pattern = loadShape("patterns/solar-system.svg");

  // crear una imagen al inico
  crearImagen();
}

void draw() {
}

void mouseReleased() {
  crearImagen();
}

void crearImagen() {

  pg = createGraphics(width, height, SVG, "print.svg");
  pg.beginDraw();
  pg.shapeMode(CENTER);
  pg.background(255);

  pg.stroke(0);
  pg.strokeWeight(4);

  drawEllipses();

  pg.shape(pattern, width/2, height/2, 100, 100);

  pg.endDraw();
  pg.dispose();

  // imprimir resultado
  result = loadShape("print.svg");
  shapeMode(CORNER);
  shape(result, 0, 0);
}

void drawEllipses() {
  for (int i=0; i<10; i++) {
    pg.ellipse(random(0, width), random(0, height), 10, 10);
  }
}
