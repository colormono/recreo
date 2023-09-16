// Lista de colores
// https://coolors.co/palette/003049-d62828-f77f00-fcbf49-eae2b7
int colors[] = {#003049, #D62828, #F77F00, #FCBF49, #EAE2B7};

// Alternar colores?
boolean shuffle = false;

void setup() {
  size(500, 500);
}

void draw() {
  // Ancho del lienzo / cantidad de colores en la lista
  int rectWidth = width / colors.length;
  noStroke();

  for (int i = 0; i<colors.length; i++) {
    if (shuffle) {
      fill( rcol() ); // elegir al azar un color de la lista
    } else {
      fill(colors[i]); // elegir el color de la lista siguiendo el orden
    }
    rect(rectWidth*i, 0, rectWidth, height);
  }

  // deshabilitar loop
  noLoop();
}

void mouseReleased() {
  // invertir el valor de shuffle
  shuffle = !shuffle;
  // habilitar loop
  loop();
}

void keyPressed() {
  // Guardar el frame como render-000001.png, render-000002.png, etc.
  if (key == 's' || key == 'S') {
    saveFrame("render-######.png");
  }
}

// devolver al azar un elemento de la lista de colores
int rcol() {
  return colors[floor(random(colors.length))];
  // random devuelve numeros flotanes, y el indice de lista requiere un numero entero
  // floor() redondea para abajo (ej. 0.24 => 0)
}
