// agregar que al grabar genere un txt con las variables de composicion
import processing.svg.*;  
boolean saveSVG = false;  // handle SVG saving
String filename;          // handle filename

ArrayList<Bloque> bloques;

int colors[] = {#f2f4f6, #1ee3cf, #6b48ff, #0d3f67};
//int colors[] = {#000000, #FF0000, #0000FF};

void setup() {
  //size(595, 842);
  //size(758, 1072);
  //size(1072, 1072);
  size(828, 828); // cuadrado maximo para hoja A3

  // create particles
  compose();
}

void draw() {
  background(255);
  strokeWeight(1);
  noFill();

  for (int x = 0; x < bloques.size(); x++) {
    if (saveSVG) beginRecord(SVG, filename + "-" + x + ".svg");
    Bloque b = bloques.get(x);
    b.draw();
    trimMarks();
    if (saveSVG) endRecord();
  }


  if (saveSVG) {
    saveFrame(filename + ".png");
    saveSVG = false;
  }
}

void mouseReleased() {
  compose();
}

void compose() {
  int NUM_BLOQUES = (int) random(3, 21); 

  bloques = new ArrayList<Bloque>();
  for (int i = 0; i< NUM_BLOQUES; i++) {  
    float _w = (random(100) > 90) ? width/random(1, 3) : width; 
    float _h = random(height/9, height/3); 
    int _x = int(width/2 - _w/2); 
    int _y = (int) random(height); 
    int _density = 3; 
    color _color = rcol();
    float _angle = random(-3, 3); 
    float _speed = 0;
    Bloque b = new Bloque(_x, _y, _w, _h, _density, _color, _angle, _speed);
    bloques.add(b);
  }
}

void keyReleased() {
  filename = "prints/" + timestamp();
  if (key == 's' || key == 'S') saveFrame(filename + ".png");
  else if (key == 'p' || key == 'P') saveSVG = true;
  else compose();
}
