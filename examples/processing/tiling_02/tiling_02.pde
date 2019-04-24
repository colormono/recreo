import processing.svg.*;
PShape result;
PGraphics pg;

PGraphics[] layers;
Pattern[] grid = {};
float cellSize = 40;

void setup() {
  //size(2560, 1440);
  //size(1190, 1684);
  size(595, 842);

  crearImagen();
}

void crearImagen() {
  // limpiar grilla
  grid = new Pattern[0];
  // para cada celda de la grilla
  for (int y=0; y<=height; y+=cellSize) {
    for (int x=0; x<=width; x+=cellSize) {
      // generar un pattern
      int layer = floor(random(6));
      Pattern p = new Pattern(pg, layer, x, y, cellSize);
      // insertarlo en la grilla
      grid = (Pattern[]) append(grid, p);            
    }
  }
  dibujarImagen();
}

void dibujarImagen() {
  pg = createGraphics(width, height, SVG, "print.svg");
  pg.beginDraw();
  pg.shapeMode(CENTER);
  pg.background(255);
  
  // para cada celda
  for (int i=0; i<grid.length; i++) {
      pg.stroke(0);
      pg.strokeWeight(1);
      grid[i].drawPattern(grid[i].layer + 1);
  }
  pg.endDraw();
  pg.dispose();

  // imprimir resultado
  result = loadShape("print.svg");
  shapeMode(CORNER);
  shape(result, 0, 0);
  saveFrame("thumbnail.png");
}

void mousePressed() {
  crearImagen();
}

void draw() {
}
