// WALL DRAWING 413
// https://massmoca.org/event/walldrawing413/
/*
Drawing Series IV (A) with color ink washes. (24 drawings.)
 March 1984
 
 Color ink wash
 LeWitt Collection, Chester, Connecticut
 
 First Installation
 Moderna Museet, Stockholm
 
 First Drawn By
 David Higginbotham, Jo Watanabe
 
 MASS MoCA Building 7
 Second Floor
 
 In the early 1980s, Sol LeWitt began to use India ink and colored ink washes, 
 which are applied to walls with soft rags, a technique that creates jewel-tone 
 colors and gives the works a fresco-like quality. 
 LeWitt frequently applied the same systems to this new medium that he had used 
 when working with pencil. He assigned gray, yellow, red, and blue ink washes 
 to stand in for the four basic types of line; gray ink wash took the place 
 of vertical lines, yellow replaced horizontal, red replaced diagonal left 
 to right lines, and blue was used for diagonal right to left.
 
 In Wall Drawing 413, LeWitt executed his Drawing Series IV using ink. 
 Between 1969 and 1970, he created four drawing series on paper. In each series 
 he applied a different system of change to each of twenty-four possible combinations 
 of a square divided into four equal parts, each containing one of the four basic 
 types of lines LeWitt used. The result is four possible permutations for each of 
 the twenty-four original units, which are presented in a grid of twenty-four 
 sets of four squares, each divided into four equal parts. In Drawing Series IV, 
 LeWitt used the Cross Reverse method of change, in which the parts of each of 
 the original units are crossed and reversed. When drawn on the wall in ink, 
 the irregular, colorful patterns made by these permutations become boldly evident. 
 At MASS MoCA, Wall Drawing 413 is displayed across from Wall Drawing 414, 
 a gray iteration of the same drawing series.
 
 */
import processing.svg.*;
PGraphics pg;

int layers = 4;
PShape[] result = new PShape[4];
Pattern[] grid = {};

int[][][] combinations = {
  {{0, 1, 2, 3}, {1, 2, 3, 0}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{1, 2, 3, 0}, {1, 2, 3, 0}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{2, 3, 0, 1}, {1, 2, 3, 0}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{3, 0, 1, 2}, {1, 2, 3, 0}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 

  {{0, 1, 2, 3}, {2, 3, 0, 1}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{1, 2, 3, 0}, {2, 3, 0, 1}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{2, 3, 0, 1}, {2, 3, 0, 1}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 
  {{3, 0, 1, 2}, {2, 3, 0, 1}, {2, 3, 1, 0}, {3, 0, 1, 2}}, 

  {{0, 1, 2, 3}, {2, 3, 0, 1}, {3, 1, 0, 2}, {3, 0, 1, 2}}, 
  {{1, 2, 3, 0}, {2, 3, 0, 1}, {3, 1, 0, 2}, {3, 0, 1, 2}}, 
  {{2, 3, 0, 1}, {2, 3, 0, 1}, {3, 1, 0, 2}, {3, 0, 1, 2}}, 
  {{3, 0, 1, 2}, {2, 3, 0, 1}, {3, 1, 0, 2}, {3, 0, 1, 2}}, 

  {{0, 1, 2, 3}, {2, 3, 0, 1}, {3, 1, 0, 2}, {0, 1, 2, 3}}, 
  {{1, 2, 3, 0}, {2, 3, 0, 1}, {3, 1, 0, 2}, {0, 1, 2, 3}}, 
  {{2, 3, 0, 1}, {2, 3, 0, 1}, {3, 1, 0, 2}, {0, 1, 2, 3}}, 
  {{3, 0, 1, 2}, {2, 3, 0, 1}, {3, 1, 0, 2}, {0, 1, 2, 3}}, 

  {{0, 1, 3, 2}, {1, 2, 0, 3}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{1, 3, 2, 0}, {1, 2, 0, 3}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{3, 2, 0, 1}, {1, 2, 0, 3}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{2, 0, 1, 3}, {1, 2, 0, 3}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 

  {{0, 1, 3, 2}, {2, 0, 3, 1}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{1, 3, 2, 0}, {2, 0, 3, 1}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{3, 2, 0, 1}, {2, 0, 3, 1}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 
  {{2, 0, 1, 3}, {2, 0, 3, 1}, {2, 3, 0, 1}, {3, 0, 2, 1}}, 

  {{0, 1, 3, 2}, {2, 0, 3, 1}, {3, 0, 1, 2}, {3, 0, 2, 1}}, 
  {{1, 3, 2, 0}, {2, 0, 3, 1}, {3, 0, 1, 2}, {3, 0, 2, 1}}, 
  {{3, 2, 0, 1}, {2, 0, 3, 1}, {3, 0, 1, 2}, {3, 0, 2, 1}}, 
  {{2, 0, 1, 3}, {2, 0, 3, 1}, {3, 0, 1, 2}, {3, 0, 2, 1}}, 

  {{0, 1, 3, 2}, {2, 0, 3, 1}, {3, 0, 1, 2}, {0, 2, 1, 3}}, 
  {{1, 3, 2, 0}, {2, 0, 3, 1}, {3, 0, 1, 2}, {0, 2, 1, 3}}, 
  {{3, 2, 0, 1}, {2, 0, 3, 1}, {3, 0, 1, 2}, {0, 2, 1, 3}}, 
  {{2, 0, 1, 3}, {2, 0, 3, 1}, {3, 0, 1, 2}, {0, 2, 1, 3}}, 

  {{0, 2, 1, 3}, {1, 3, 0, 2}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{2, 1, 3, 0}, {1, 3, 0, 2}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{1, 3, 0, 2}, {1, 3, 0, 2}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{3, 0, 2, 1}, {1, 3, 0, 2}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 

  {{0, 2, 1, 3}, {3, 0, 2, 1}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{2, 1, 3, 0}, {3, 0, 2, 1}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{1, 3, 0, 2}, {3, 0, 2, 1}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 
  {{3, 0, 2, 1}, {3, 0, 2, 1}, {2, 1, 0, 3}, {3, 2, 0, 1}}, 

  {{0, 2, 1, 3}, {3, 0, 2, 1}, {1, 0, 3, 2}, {3, 2, 0, 1}}, 
  {{2, 1, 3, 0}, {3, 0, 2, 1}, {1, 0, 3, 2}, {3, 2, 0, 1}}, 
  {{1, 3, 0, 2}, {3, 0, 2, 1}, {1, 0, 3, 2}, {3, 2, 0, 1}}, 
  {{3, 0, 2, 1}, {3, 0, 2, 1}, {1, 0, 3, 2}, {3, 2, 0, 1}}, 

  {{0, 2, 1, 3}, {3, 0, 2, 1}, {1, 0, 3, 2}, {2, 0, 1, 3}}, 
  {{2, 1, 3, 0}, {3, 0, 2, 1}, {1, 0, 3, 2}, {2, 0, 1, 3}}, 
  {{1, 3, 0, 2}, {3, 0, 2, 1}, {1, 0, 3, 2}, {2, 0, 1, 3}}, 
  {{3, 0, 2, 1}, {3, 0, 2, 1}, {1, 0, 3, 2}, {2, 0, 1, 3}}, 

  {{0, 2, 3, 1}, {1, 3, 2, 0}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{2, 3, 1, 0}, {1, 3, 2, 0}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{3, 1, 0, 2}, {1, 3, 2, 0}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{1, 0, 2, 3}, {1, 3, 2, 0}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 

  {{0, 2, 3, 1}, {3, 2, 0, 1}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{2, 3, 1, 0}, {3, 2, 0, 1}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{3, 1, 0, 2}, {3, 2, 0, 1}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 
  {{1, 0, 2, 3}, {3, 2, 0, 1}, {2, 1, 3, 0}, {3, 2, 1, 0}}, 

  {{0, 2, 3, 1}, {3, 2, 0, 1}, {1, 3, 0, 2}, {3, 2, 1, 0}}, 
  {{2, 3, 1, 0}, {3, 2, 0, 1}, {1, 3, 0, 2}, {3, 2, 1, 0}}, 
  {{3, 1, 0, 2}, {3, 2, 0, 1}, {1, 3, 0, 2}, {3, 2, 1, 0}}, 
  {{1, 0, 2, 3}, {3, 2, 0, 1}, {1, 3, 0, 2}, {3, 2, 1, 0}}, 

  {{0, 2, 3, 1}, {3, 2, 0, 1}, {1, 3, 0, 2}, {2, 1, 0, 3}}, 
  {{2, 3, 1, 0}, {3, 2, 0, 1}, {1, 3, 0, 2}, {2, 1, 0, 3}}, 
  {{3, 1, 0, 2}, {3, 2, 0, 1}, {1, 3, 0, 2}, {2, 1, 0, 3}}, 
  {{1, 0, 2, 3}, {3, 2, 0, 1}, {1, 3, 0, 2}, {2, 1, 0, 3}}, 

  {{0, 3, 1, 2}, {1, 0, 2, 3}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{3, 1, 2, 0}, {1, 0, 2, 3}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{1, 2, 0, 3}, {1, 0, 2, 3}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{2, 0, 3, 1}, {1, 0, 2, 3}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 

  {{0, 3, 1, 2}, {0, 2, 3, 1}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{3, 1, 2, 0}, {0, 2, 3, 1}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{1, 2, 0, 3}, {0, 2, 3, 1}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 
  {{2, 0, 3, 1}, {0, 2, 3, 1}, {2, 0, 1, 3}, {3, 1, 0, 2}}, 

  {{0, 3, 1, 2}, {0, 2, 3, 1}, {0, 1, 3, 2}, {3, 1, 0, 2}}, 
  {{3, 1, 2, 0}, {0, 2, 3, 1}, {0, 1, 3, 2}, {3, 1, 0, 2}}, 
  {{1, 2, 0, 3}, {0, 2, 3, 1}, {0, 1, 3, 2}, {3, 1, 0, 2}}, 
  {{2, 0, 3, 1}, {0, 2, 3, 1}, {0, 1, 3, 2}, {3, 1, 0, 2}}, 

  {{0, 3, 1, 2}, {0, 2, 3, 1}, {0, 1, 3, 2}, {1, 0, 2, 3}}, 
  {{3, 1, 2, 0}, {0, 2, 3, 1}, {0, 1, 3, 2}, {1, 0, 2, 3}}, 
  {{1, 2, 0, 3}, {0, 2, 3, 1}, {0, 1, 3, 2}, {1, 0, 2, 3}}, 
  {{2, 0, 3, 1}, {0, 2, 3, 1}, {0, 1, 3, 2}, {1, 0, 2, 3}}, 

  {{0, 3, 2, 1}, {1, 0, 3, 2}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{3, 2, 1, 0}, {1, 0, 3, 2}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{2, 1, 0, 3}, {1, 0, 3, 2}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{1, 0, 3, 2}, {1, 0, 3, 2}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 

  {{0, 3, 2, 1}, {0, 3, 2, 1}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{3, 2, 1, 0}, {0, 3, 2, 1}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{2, 1, 0, 3}, {0, 3, 2, 1}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 
  {{1, 0, 3, 2}, {0, 3, 2, 1}, {2, 0, 3, 1}, {3, 1, 2, 0}}, 

  {{0, 3, 2, 1}, {0, 3, 2, 1}, {0, 3, 1, 2}, {3, 1, 2, 0}}, 
  {{3, 2, 1, 0}, {0, 3, 2, 1}, {0, 3, 1, 2}, {3, 1, 2, 0}}, 
  {{2, 1, 0, 3}, {0, 3, 2, 1}, {0, 3, 1, 2}, {3, 1, 2, 0}}, 
  {{1, 0, 3, 2}, {0, 3, 2, 1}, {0, 3, 1, 2}, {3, 1, 2, 0}}, 

  {{0, 3, 2, 1}, {0, 3, 2, 1}, {0, 3, 1, 2}, {1, 2, 0, 3}}, 
  {{3, 2, 1, 0}, {0, 3, 2, 1}, {0, 3, 1, 2}, {1, 2, 0, 3}}, 
  {{2, 1, 0, 3}, {0, 3, 2, 1}, {0, 3, 1, 2}, {1, 2, 0, 3}}, 
  {{1, 0, 3, 2}, {0, 3, 2, 1}, {0, 3, 1, 2}, {1, 2, 0, 3}}
};

void setup() {
  //size(2560, 1440);
  //size(1190, 1684);
  size(595, 842);
  background(255);

  crearImagen();
}

void crearImagen() {
  // limpiar grilla
  grid = new Pattern[0];

  // sistema
  int cellSize = 13;
  int cols = 8;
  int margin = 8;
  int padding = 4;
  int setX = margin;
  int setY = margin;

  // para cada grupo
  for (int x=0; x<combinations.length; x++) {
    if (x % cols == 0 && x != 0) {
      setX = margin;
      setY += cellSize * 4 + margin * 2;
    } else if ( x > 0 ) {
      setX += cellSize * 4 + margin * 2;
    }

    // para cada subgrupo
    for (int y=0; y<4; y++) {
      int subsetX = setX + padding;
      int subsetY = setY + padding;

      // impares a la derecha
      if (y % 2 != 0) {
        subsetX = setX + cellSize * 2 + padding * 2;
      }

      // mayores abajo
      if (y >= 2) {
        subsetY = setY + cellSize * 2 + padding * 2;
      }

      // para cada patron
      for (int z=0; z<4; z++) {
        int posX = subsetX;
        int posY = subsetY;

        // impares a la derecha
        if (z % 2 != 0) {
          posX += cellSize;
        } 

        // mayores abajo
        if (z >= 2) {
          posY += cellSize;
        }

        // insertar patron
        int layer = combinations[x][y][z];
        Pattern p = new Pattern(pg, layer, posX, posY, cellSize);
        grid = (Pattern[]) append(grid, p);
      }
    }
  }
  dibujarImagen();
}

void dibujarImagen() {
  // para cada layer 
  for (int l=0; l<layers; l++) {
    pg = createGraphics(width, height, SVG, "print-layer-"+l+".svg");
    pg.beginDraw();
    pg.shapeMode(CENTER);
    //pg.background(255);

    // para cada celda
    for (int i=0; i<grid.length; i++) {
      if (l == grid[i].layer) {
        pg.strokeWeight(1);
        grid[i].drawPattern(grid[i].layer);
      }
    }
    pg.endDraw();
    pg.dispose();

    // imprimir resultado
    result[l] = loadShape("print-layer-"+l+".svg");
    shapeMode(CORNER);
    shape(result[l], 0, 0);
  }

  saveFrame("thumbnail.png");
}

void mousePressed() {
  crearImagen();
}

void draw() {
}
