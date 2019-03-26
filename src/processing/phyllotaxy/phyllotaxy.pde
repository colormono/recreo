/*
  Equivalent A4 paper dimensions in pixels at 300 DPI and 72 DPI respectively are: 
 2480 pixels x 3508 pixels (print resolution) 
 595 pixels x 842 pixels (screen resolution)
 */
import processing.svg.*;
PGraphics pg;
PShape result;

void setup() {
  size(1190, 1684);

  // crear una imagen al inico
  crearImagen();
}

void draw() {
}

void crearImagen() {
  pg = createGraphics(width, height, SVG, "print.svg");
  pg.beginDraw();
  pg.shapeMode(CENTER);
  pg.background(255);

  pg.translate(width/2, height/2);
  for (int i=0; i<360; i++) {
    float x = i*sin(i);
    float y = i*cos(i);
    pg.strokeWeight(1);
    pg.stroke(0);
    float r = i/25;
    if (r>1) {
      pg.ellipse(x*1.2, y*1.2, r, r);
    } else {
      pg.ellipse(x*1.2, y*1.2, 1, 1);
    }
  }

  pg.endDraw();
  pg.dispose();

  // imprimir resultado
  result = loadShape("print.svg");
  shapeMode(CORNER);
  shape(result, 0, 0);
}
